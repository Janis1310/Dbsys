import javax.swing.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.*;
import java.util.LinkedList;

public class Gui {
    public static void main(String[] args) throws SQLException {
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        String url = "jdbc:oracle:thin:@oracle19c.in.htwg-konstanz.de:1521:ora19c";
        Connection conn = DriverManager.getConnection(url, "dbsys16", "dbsys16");
        Statement stmt = conn.createStatement();

// Fetching data for 'laender'
        ResultSet rs = stmt.executeQuery("SELECT * FROM LAND");
        ArrayList<String> laender = new ArrayList<>();
        while (rs.next()) {
            String r1 = rs.getString("BEZEICHNUNG");
            laender.add(r1);
        }
        rs.close();


        ArrayList<String> ausstattungen = new ArrayList<>();
        ResultSet rsAustattungen = stmt.executeQuery("SELECT * FROM Ausstattung");
        while (rsAustattungen.next()) {
            String r1 = rsAustattungen.getString("bezeichnung");
            ausstattungen.add(r1);
        }
        rsAustattungen.close();


        stmt.close();
        conn.close();

        JFrame rahmen = new JFrame("Responsive GUI");
        rahmen.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        rahmen.setSize(600, 600);

        JPanel hauptPanel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.fill = GridBagConstraints.BOTH;
        gbc.insets = new Insets(5, 5, 5, 5);

        // Obere Ebene (z. B. Header)
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.weightx = 1;
        gbc.weighty = 0.1;
        JPanel oberesPanel = new JPanel();
        oberesPanel.setBackground(Color.pink);
        oberesPanel.add(new JLabel("Ferienwohnungen suchen und buchen"));
        hauptPanel.add(oberesPanel, gbc);

        // Mittlere Ebene (z. B. Inhalte)
        gbc.gridx = 0;
        gbc.gridy = 1;
        gbc.weightx = 1;
        gbc.weighty = 0.8;
        JPanel mittleresPanel = new JPanel();
        mittleresPanel.setBackground(Color.pink);
        mittleresPanel.setLayout(new BoxLayout(mittleresPanel, BoxLayout.Y_AXIS));

        JLabel anreiselabel = new JLabel ("Anreise in (dd.mm.yyyy) (n.n)");
        JTextField anreise = new JTextField();
        mittleresPanel.add(anreiselabel);
        mittleresPanel.add(anreise);

        JLabel abreiseLabel = new JLabel ("Abreise in (dd.mm.yyyy) (n.n)");
        JTextField abreise = new JTextField();
        mittleresPanel.add(abreiseLabel);
        mittleresPanel.add(abreise);


        String[] ausstattungenArray = ausstattungen.toArray(new String[0]);
        for (String s : ausstattungenArray) {
            mittleresPanel.add(new Checkbox(s));
        }


        String [] laenderArray = laender.toArray(new String[0]);
        JComboBox<String> land = new JComboBox<>(laenderArray);

        mittleresPanel.add(land);

        hauptPanel.add(mittleresPanel, gbc);

        //Suchbutton
        JButton button = new JButton("Suchen");
        button.setBounds(100, 70, 100, 30);

        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String beginDatum = anreise.getText();
                String endDatum = abreise.getText();
                String selectedLand = (String) land.getSelectedItem();
                ArrayList<String> selectedAusstattungen = new ArrayList<>();

                // Ausgewählte Checkboxen für Ausstattung sammeln
                for (Component component : mittleresPanel.getComponents()) {
                    if (component instanceof Checkbox) {
                        Checkbox checkbox = (Checkbox) component;
                        if (checkbox.getState()) {
                            selectedAusstattungen.add(checkbox.getLabel());
                        }
                    }
                }

                if (beginDatum.matches("\\d{2}.\\d{2}.\\d{4}") && endDatum.matches("\\d{2}.\\d{2}.\\d{4}")) {
                    GUIFerienwohnungen.neuesFensterAnzeigen(selectedLand, selectedAusstattungen, beginDatum, endDatum);
                } else {
                    JOptionPane.showMessageDialog(rahmen, "Datum nicht im richtigen Format");
                }
            }
        });






        // Untere Ebene (z. B. Footer)
        gbc.gridx = 0;
        gbc.gridy = 2;
        gbc.weightx = 1;
        gbc.weighty = 0.1;
        JPanel unteresPanel = new JPanel();
        unteresPanel.setBackground(Color.pink);

        unteresPanel.add(button);
        hauptPanel.add(unteresPanel, gbc);

        rahmen.add(hauptPanel);
        rahmen.setVisible(true);

    }

}