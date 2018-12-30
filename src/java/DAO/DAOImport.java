/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnection;
import Model.BookImport;
import Model.Import;
import com.mysql.jdbc.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author mito
 */
public class DAOImport {
    public static ArrayList<Import> getListImport() throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM imports";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Import> list = new ArrayList<>();
        while(rs.next()) {
            Import impor = new Import();
            impor.setId(rs.getInt("id"));
            impor.setPublisher(rs.getString("publisher"));
            impor.setNote(rs.getString("note"));
            impor.setCreated_at(rs.getString("created_at"));
            impor.setDeleted_at(rs.getString("deleted_at"));
            list.add(impor);
        }
        return list;
    }
    
    public static int save(Import imp) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "INSERT INTO imports(publisher, note) VALUES(?,?)";
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setNString(1, imp.getPublisher());
        ps.setNString(2, imp.getNote());
        ps.executeUpdate();
        int import_id = 0;
        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                import_id = generatedKeys.getInt(1);
            }
            else {
                throw new SQLException("Creating user failed, no ID obtained.");
            }
        }
        return import_id;
    }
    
    public static void attach(int import_id, BookImport book) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "INSERT INTO book_import(import_id, book_id, quantity) VALUES(?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, import_id);
        ps.setInt(2, book.id);
        ps.setInt(3, book.quantity);
        ps.executeUpdate();
    }
    
    public static void delete(int imp_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE imports SET deleted_at=CURRENT_TIMESTAMP() WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, imp_id);
        ps.executeUpdate();
    }
    
    public static void restore(int imp_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE imports SET deleted_at=NULL WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, imp_id);
        ps.executeUpdate();
    }
    
    public static Import find(int id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM imports WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Import imp = new Import();
        if(rs.first()) {
            imp.setId(rs.getInt("id"));
            imp.setPublisher(rs.getString("publisher"));
            imp.setNote(rs.getString("note"));
            imp.setCreated_at(rs.getString("created_at"));
            imp.setDeleted_at(rs.getString("deleted_at"));
        }
        return imp;
    }
    
    public static ArrayList<Map<String, String>> getBookImport(int id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT books.id, books.name, books.slug, book_import.quantity as import_quantity FROM books LEFT JOIN book_import ON books.id = book_import.book_id WHERE import_id = ? ";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        ArrayList<Map<String, String>> list = new ArrayList<>();
        while(rs.next()) {
            Map<String, String> book = new HashMap<String, String>();
            book.put("id", rs.getString("id"));
            book.put("name", rs.getString("name")); 
            book.put("slug", rs.getString("slug")); 
            book.put("import_quantity", rs.getString("import_quantity")); 
            list.add(book);
        }
        return list;
    }
}
