/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Database;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author mito
 */
public class DBConnection {
    public static Connection getConnection()
    {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop", "root", "b15dcpt082");
            // conn.setCharacterEncoding("utf-8");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
