import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;
import java.util.Properties;

import com.opencsv.CSVWriter;
import io.github.cdimascio.dotenv.*;
import io.questdb.cutlass.line.LineTcpSender;
import io.questdb.network.Net;
import io.questdb.std.Os;



public class QuestDBTester {
    static Properties properties;
    static Connection connection;

    public QuestDBTester() throws SQLException {
        Dotenv dotenv = Dotenv.load();
        String link = dotenv.get("QUEST_LINK");
        int num_tests = Integer.parseInt(dotenv.get("NUM_TESTS"));
        properties = new Properties();
        properties.setProperty("user", "admin");
        properties.setProperty("password", "quest");
        properties.setProperty("sslmode", "disable");
        connection = DriverManager.getConnection(link, properties);
        connection.setAutoCommit(false);
        File file = new File("quest.csv");
        try {

            System.out.println("BEGIN");
            // create FileWriter object with file as parameter
            FileWriter outputfile = new FileWriter(file);

            // create CSVWriter object filewriter object as parameter
            CSVWriter writer = new CSVWriter(outputfile);

            // adding header to csv
            String[] header = { "Trial", "Q1", "Q3", "Q4"};
            writer.writeNext(header);

            // add data to csv
            System.out.println("BEGIN");

            long single1 = query1();
            long single2 = query3();
            long single3 = query4();
            System.out.println(single1);
            System.out.println(single2);
            System.out.println(single3);

            String[] data1 = { "SINGLE", String.valueOf(single1), String.valueOf(single2), String.valueOf(single3)};
            writer.writeNext(data1);

            for (int i = 0; i < num_tests; i++) {
                long data = query1();
                long data2 = query3();
                long data3 = query4();
                System.out.println(data);
                System.out.println(data2);
                System.out.println(data3);
                String[] text2 = {String.valueOf(i), String.valueOf(data), String.valueOf(data2), String.valueOf(data3)};
                writer.writeNext(text2);
            }
            writer.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static void main(String[] args) throws SQLException {
        new QuestDBTester();
    }

    public static long query1() throws SQLException
    {
        System.out.println("BEGIN1");
        long startTime = System.nanoTime();
        try (PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, TradeDate, month(TradeDate), avg(ClosePrice), max(ClosePrice), min(ClosePrice) from price, WHERE year(TradeDate) > 2022 AND year(TradeDate) < 2032 GROUP by id, TradeDate, month(TradeDate) ORDER BY id, TradeDate;")) {
            System.out.println("BEGIN2");
            try (ResultSet rs = preparedStatement.executeQuery()) {
                System.out.println("BEGIN3");

                try (PreparedStatement preparedStatement2 = connection.prepareStatement("SELECT id, TradeDate, year(TradeDate), avg(ClosePrice), max(ClosePrice), min(ClosePrice) from price, WHERE year(TradeDate) > 2022 AND year(TradeDate) < 2032 GROUP by id, TradeDate, year(TradeDate) ORDER BY id, TradeDate;")) {
                    System.out.println("BEGIN4");

                    try (ResultSet rs2 = preparedStatement2.executeQuery()) {
                        System.out.println("BEGIN5");

                        try (PreparedStatement preparedStatement3 = connection.prepareStatement("SELECT id, TradeDate, day(TradeDate), avg(ClosePrice), max(ClosePrice), min(ClosePrice) from price, WHERE year(TradeDate) > 2022 AND year(TradeDate) < 2032 GROUP by id, TradeDate, day(TradeDate) ORDER BY id, TradeDate;")) {
                            System.out.println("BEGIN6");

                            try (ResultSet rs3 = preparedStatement3.executeQuery()) {
                                System.out.println("BEGIN7");

                            }
                        }
                    }
                }
            }
        }
        System.out.println("BEGIN8");

        long endTime = System.nanoTime();
        System.out.println(endTime-startTime);
        return (endTime-startTime);

    }

    public static long query3() throws SQLException {
        long startTime = System.nanoTime();
        Statement stmt=connection.createStatement();
        stmt.executeQuery("SELECT avg(closeprice) FROM price a, base b WHERE a.id = b.id  AND b.SIC = 'COMPUTERS';");
        long endTime = System.nanoTime();
        System.out.println(endTime-startTime);
        return (endTime-startTime);
    }
    public static long query4() throws SQLException {
        long startTime = System.nanoTime();
        Statement stmt=connection.createStatement();
        stmt.executeQuery("SELECT a.id, tradedate, lowprice, highprice FROM price a, split b WHERE a.id=b.id AND a.tradedate=b.splitdate;");
        long endTime = System.nanoTime();
        System.out.println(endTime-startTime);
        return (endTime-startTime);
    }

}