import java.sql.*;
public class testJava {
    public static void main(String[] args) throws SQLException{

        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url= "jdbc:oracle:thin:@oracle19c.in.htwg-konstanz.de:1521:ora19c";
        Connection conn = DriverManager.getConnection( url, "dbsys16","dbsys16");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(
                "SELECT * FROM Adresse WHERE landbezeichnung = 'Frankreich'");
        while (rs.next()) {
            System.out.println("test");
            String r1 = rs.getString("landbezeichnung");
            int r2 = rs.getInt("adressnr");
            System.out.println(r2 + r1);
        }
        rs.close(); stmt.close(); conn.close();
    }
}