import javax.swing.*;
import java.awt.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class GUIFerienwohnungen extends Gui {
    public static ArrayList<String> fetchFerienWohnungenAnzeige(String land, String ausstattung, String startDate, String endDate) {
        ArrayList<String> ferienWohnungenAnzeige = new ArrayList<>();
        try {
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            String url = "jdbc:oracle:thin:@oracle19c.in.htwg-konstanz.de:1521:ora19c";
            Connection conn = DriverManager.getConnection(url, "dbsys16", "dbsys16");
            Statement stmt = conn.createStatement();

            String query = """
                    SELECT fw.ferienwohnungsname, COALESCE(AVG(b.sternanzahl), 0) AS durchschnittliche_bewertung
                    FROM Ferienwohnung fw
                        JOIN Adresse a ON fw.adressnr = a.adressnr
                        JOIN Land l ON a.landbezeichnung = l.bezeichnung
                        JOIN besitzt be ON fw.ferienwohnungsname = be.ausstattungsbezeichnung
                        LEFT JOIN Buchung b ON fw.ferienwohnungsname = b.ferienwohnungsname
                    WHERE l.bezeichnung = ?
                    """;



            ResultSet rsFerienWohnungenAnzeige = stmt.executeQuery(query);

            while (rsFerienWohnungenAnzeige.next()) {
                String name = rsFerienWohnungenAnzeige.getString("ferienwohnungsname");
                String bewertung = rsFerienWohnungenAnzeige.getString("durchschnittliche_bewertung");
                ferienWohnungenAnzeige.add(name + " - " + bewertung);
            }
            rsFerienWohnungenAnzeige.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ferienWohnungenAnzeige;
    }

    public static void neuesFensterAnzeigen(String land, ArrayList<String> ausstattung, String startDate, String endDate) {
        // Neues Fenster erstellen
        JFrame rahmen = new JFrame("Neues Fenster");
        rahmen.setSize(300, 200);
        rahmen.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE); // Nur dieses Fenster schließen
        rahmen.setLayout(new FlowLayout());

        // Label hinzufügen
        JLabel label = new JLabel("Ferienwohnungen");
        rahmen.add(label);

        String[] ferienwohnungenAnzeigeArray = fetchFerienWohnungenAnzeige(land, String.valueOf(ausstattung), startDate, endDate).toArray(new String[0]);
        for (String item : ferienwohnungenAnzeigeArray) {
            rahmen.add(new Checkbox(item));
        }

        // Neues Fenster sichtbar machen
        rahmen.setVisible(true);
    }
}