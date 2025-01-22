import javax.swing.*;
import java.awt.*;
import java.sql.*;
import java.util.ArrayList;




public class GUIFerienwohnungen extends Gui {


    public static ArrayList<String> fetchFerienWohnungenAnzeige(String land, ArrayList<String> ausstattung, String startDate, String endDate) {
        ArrayList<String> ferienWohnungenAnzeige = new ArrayList<>();
        try {
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            String url = "jdbc:oracle:thin:@oracle19c.in.htwg-konstanz.de:1521:ora19c";
            Connection conn = DriverManager.getConnection(url, "dbsys16", "dbsys16");

            // Dynamisch Platzhalter für die IN-Klausel generieren
            String inClause = ausstattung.isEmpty() ? "1=1" : String.join(",", ausstattung.stream().map(s -> "?").toArray(String[]::new));

            String sql = """
            SELECT fw.ferienwohnungsname, COALESCE(AVG(b.sternanzahl), 0) AS durchschnittliche_bewertung
            FROM dbsys16.Ferienwohnung fw
                JOIN Adresse a ON fw.adressnr = a.adressnr
                JOIN Land l ON a.landbezeichnung = l.bezeichnung
                LEFT JOIN besitzt be ON fw.ferienwohnungsname = be.ausstatungsbezeichnung
                LEFT JOIN Buchung b ON fw.ferienwohnungsname = b.ferienwohnungsname
            WHERE l.bezeichnung = ?
              AND NOT EXISTS (
                  SELECT 1
                  FROM dbsys16.Buchung b2
                  WHERE b2.ferienwohnungsname = fw.ferienwohnungsname
                    AND (
                        b2.anreise <= TO_DATE(?, 'DD-MM-YYYY') 
                        AND b2.abreise >= TO_DATE(?, 'DD-MM-YYYY')
                    )
              )
              AND (%s)
            GROUP BY fw.ferienwohnungsname
        """.formatted(inClause.equals("1=1") ? "1=1" : String.format(
                    "fw.ferienwohnungsname IN (SELECT ferienwohnungsname FROM dbsys16.besitzt WHERE ausstatungsbezeichnung IN (%s) GROUP BY ferienwohnungsname HAVING COUNT(DISTINCT ausstatungsbezeichnung) = ?)",
                    inClause
            ));

            PreparedStatement preparedStatement = conn.prepareStatement(sql);

            int paramIndex = 1;
            preparedStatement.setString(paramIndex++, land);
            preparedStatement.setString(paramIndex++, endDate);
            preparedStatement.setString(paramIndex++, startDate);


            if (!ausstattung.isEmpty()) {
                for (String aus : ausstattung) {
                    preparedStatement.setString(paramIndex++, aus);
                }
                preparedStatement.setInt(paramIndex++, ausstattung.size());
            }


            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String name = rs.getString("ferienwohnungsname");
                String bewertung = rs.getString("durchschnittliche_bewertung");
                ferienWohnungenAnzeige.add(name + " - Bewertung: " + bewertung);
            }

            rs.close();
            preparedStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ferienWohnungenAnzeige;
    }




    public static void neuesFensterAnzeigen(String land, ArrayList<String> ausstattung, String startDate, String endDate) {
        JFrame rahmen = new JFrame("Suchergebnisse");
        rahmen.setSize(600, 400);
        rahmen.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        rahmen.setLayout(new BorderLayout());

        // Haupt-Panel für den Hintergrund
        JPanel mainPanel = new JPanel(new BorderLayout());
        mainPanel.setBackground(Color.PINK); // Setze den Hintergrund des Haupt-Containers auf Pink
        rahmen.add(mainPanel);

        JLabel headerLabel = new JLabel("Ferienwohnungen in " + land, SwingConstants.CENTER);
        headerLabel.setFont(new Font("Arial", Font.BOLD, 16));
        headerLabel.setOpaque(true); // Macht den Hintergrund sichtbar
        headerLabel.setBackground(Color.PINK); // Setzt den Hintergrund des Labels auf Pink
        mainPanel.add(headerLabel, BorderLayout.NORTH);

        // Ergebnisse in einer Liste anzeigen
        ArrayList<String> ferienwohnungenAnzeige = fetchFerienWohnungenAnzeige(land, ausstattung, startDate, endDate);
        DefaultListModel<String> listModel = new DefaultListModel<>();
        for (String item : ferienwohnungenAnzeige) {
            listModel.addElement(item);
        }
        JList<String> ferienwohnungListe = new JList<>(listModel);
        JScrollPane scrollPane = new JScrollPane(ferienwohnungListe);
        scrollPane.getViewport().setBackground(Color.PINK); // Hintergrund der Scrollansicht auf Pink setzen
        mainPanel.add(scrollPane, BorderLayout.CENTER);

        // Buchungsbutton
        JButton buchenButton = new JButton("Buchen");
        buchenButton.addActionListener(e -> {
            String selected = ferienwohnungListe.getSelectedValue();
            if (selected != null) {
                // Extrahiere den Namen der Ferienwohnung aus der Auswahl
                String ferienwohnungName = selected.split(" - ")[0];

                // Buchung in der Datenbank durchführen
                if (buchen(ferienwohnungName, startDate, endDate)) {
                    JOptionPane.showMessageDialog(rahmen, "Die Ferienwohnung '" + ferienwohnungName + "' wurde erfolgreich gebucht!");
                } else {
                    JOptionPane.showMessageDialog(rahmen, "Fehler bei der Buchung der Ferienwohnung.");
                }
            } else {
                JOptionPane.showMessageDialog(rahmen, "Bitte wählen Sie eine Ferienwohnung aus.");
            }
        });

        JPanel buttonPanel = new JPanel();
        buttonPanel.setBackground(Color.PINK); // Hintergrund des Button-Panels auf Pink setzen
        buttonPanel.add(buchenButton);
        mainPanel.add(buttonPanel, BorderLayout.SOUTH);

        rahmen.setVisible(true);
    }

    public static boolean buchen(String ferienwohnungName, String startDate, String endDate) {
        try {
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            String url = "jdbc:oracle:thin:@oracle19c.in.htwg-konstanz.de:1521:ora19c";
            Connection conn = DriverManager.getConnection(url, "dbsys16", "dbsys16");

            // SQL-Abfrage, um die Buchung einzufügen
            String sql = """
                INSERT INTO Buchung (ferienwohnungsname, anreise, abreise, betrag, zahlungsart, rechnungsdatum, buchungsdatum, email)
                VALUES (?, TO_DATE(?, 'DD.MM.YYYY'), TO_DATE(?, 'DD.MM.YYYY'), ?, ?, SYSDATE, SYSDATE, ?)
            """;

            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, ferienwohnungName);
            preparedStatement.setString(2, startDate);
            preparedStatement.setString(3, endDate);
            preparedStatement.setDouble(4, 100.00);  // Beispielwert für Betrag
            preparedStatement.setString(5, "Kreditkarte");  // Beispielwert für Zahlungsart
            preparedStatement.setString(6, kunde_email);  // Beispielwert für Zahlungsart


            int rowsAffected = preparedStatement.executeUpdate();

            preparedStatement.close();
            conn.close();

            // Rückmeldung, ob die Buchung erfolgreich war
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


}