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

            // SQL-Abfrage mit WHERE-Klauseln für Filter
            String sql = """
                SELECT fw.ferienwohnungsname, COALESCE(AVG(b.sternanzahl), 0) AS durchschnittliche_bewertung
                FROM Ferienwohnung fw
                    JOIN Adresse a ON fw.adressnr = a.adressnr
                    JOIN Land l ON a.landbezeichnung = l.bezeichnung
                    LEFT JOIN besitzt be ON fw.ferienwohnungsname = be.Ausstatungsbezeichnung
                    LEFT JOIN Buchung b ON fw.ferienwohnungsname = b.ferienwohnungsname
                WHERE l.bezeichnung = ?
                    AND (? IS NULL OR fw.ferienwohnungsname IN (
                        SELECT ferienwohnungsname FROM besitzt WHERE Ausstatungsbezeichnung IN (?)))
                    AND (? IS NULL OR EXISTS (
                        SELECT 1 FROM Buchung
                        WHERE fw.ferienwohnungsname = Buchung.ferienwohnungsname
                          AND Buchung.anreise >= TO_DATE(?, 'DD.MM.YYYY')
                          AND Buchung.abreise <= TO_DATE(?, 'DD.MM.YYYY')))
                GROUP BY fw.ferienwohnungsname
                """;

            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, land);
            preparedStatement.setString(2, ausstattung.isEmpty() ? null : String.join(",", ausstattung));
            preparedStatement.setString(3, ausstattung.isEmpty() ? null : String.join(",", ausstattung));
            preparedStatement.setString(4, startDate.isEmpty() ? null : startDate);
            preparedStatement.setString(5, startDate.isEmpty() ? null : startDate);
            preparedStatement.setString(6, endDate.isEmpty() ? null : endDate);

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
        rahmen.setSize(400, 300);
        rahmen.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        rahmen.setLayout(new BoxLayout(rahmen.getContentPane(), BoxLayout.Y_AXIS));

        JLabel headerLabel = new JLabel("Ferienwohnungen in " + land);
        rahmen.add(headerLabel);

        String[] ferienwohnungenAnzeigeArray = fetchFerienWohnungenAnzeige(land, ausstattung, startDate, endDate).toArray(new String[0]);
        for (String item : ferienwohnungenAnzeigeArray) {
            rahmen.add(new JLabel(item));
        }

        rahmen.setVisible(true);
    }

}