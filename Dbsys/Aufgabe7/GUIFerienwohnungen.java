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
            FROM Ferienwohnung fw
                JOIN Adresse a ON fw.adressnr = a.adressnr
                JOIN Land l ON a.landbezeichnung = l.bezeichnung
                LEFT JOIN besitzt be ON fw.ferienwohnungsname = be.ausstatungsbezeichnung
                LEFT JOIN Buchung b ON fw.ferienwohnungsname = b.ferienwohnungsname
            WHERE l.bezeichnung = ?
              AND NOT EXISTS (
                  SELECT 1
                  FROM Buchung b2
                  WHERE b2.ferienwohnungsname = fw.ferienwohnungsname
                    AND (
                        b2.anreise <= TO_DATE(?, 'DD-MM-YYYY') 
                        AND b2.abreise >= TO_DATE(?, 'DD-MM-YYYY')
                    )
              )
              AND (%s)
            GROUP BY fw.ferienwohnungsname
        """.formatted(inClause.equals("1=1") ? "1=1" : String.format(
                    "fw.ferienwohnungsname IN (SELECT ferienwohnungsname FROM besitzt WHERE ausstatungsbezeichnung IN (%s) GROUP BY ferienwohnungsname HAVING COUNT(DISTINCT ausstatungsbezeichnung) = ?)",
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