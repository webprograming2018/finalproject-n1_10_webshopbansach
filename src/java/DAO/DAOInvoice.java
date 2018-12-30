/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnection;
import Model.Book;
import Model.Cart;
import Model.Invoice;
import Model.User;
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
public class DAOInvoice {
    public static ArrayList<Invoice> getListInvoice() throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM invoices";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Invoice> list = new ArrayList<>();
        while(rs.next()) {
            Invoice invoice = new Invoice();
            invoice.setId(rs.getInt("id"));
            invoice.setUser_id(rs.getInt("user_id"));
            invoice.setStatus(rs.getInt("status"));
            invoice.setTotal(rs.getInt("total"));
            invoice.setTotal_book(rs.getInt("total_book"));
            invoice.setShip_tax(rs.getInt("ship_tax"));
            invoice.setNote(rs.getString("note"));
            invoice.setAddress(rs.getString("address"));
            invoice.setCreated_at(rs.getString("created_at"));
            invoice.setUpdated_at(rs.getString("updated_at"));
            list.add(invoice);
        }
        return list;
    }
    
    public static int save(int user_id, int total_book, int total, String address) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "INSERT INTO invoices(user_id,total_book,total,ship_tax, address) VALUES(?,?,?,?,?)";
        PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, user_id);
        ps.setInt(2, total_book);
        ps.setInt(3, total);
        ps.setInt(4, 10);
        ps.setNString(5, address);
        ps.executeUpdate();
        int invoice_id = 0;
        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                invoice_id = generatedKeys.getInt(1);
            }
            else {
                throw new SQLException("Creating user failed, no ID obtained.");
            }
        }
        return invoice_id;
    }
    
    public static void attach(int invoice_id, Cart cart) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "INSERT INTO book_invoice(invoice_id,book_id,quantity,invoice_price) VALUES(?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, invoice_id);
        ps.setInt(2, cart.id);
        ps.setInt(3, cart.invoice_quantity);
        ps.setInt(4, cart.price);
        ps.executeUpdate();
    }
    
    public static Invoice find(int id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM invoices WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Invoice invoice = new Invoice();
        if(rs.first()) {
            invoice.setId(rs.getInt("id"));
            invoice.setUser_id(rs.getInt("user_id"));
            invoice.setStatus(rs.getInt("status"));
            invoice.setTotal(rs.getInt("total"));
            invoice.setTotal_book(rs.getInt("total_book"));
            invoice.setShip_tax(rs.getInt("ship_tax"));
            invoice.setNote(rs.getString("note"));
            invoice.setAddress(rs.getString("address"));
            invoice.setCreated_at(rs.getString("created_at"));
            invoice.setUpdated_at(rs.getString("updated_at"));
        }
        return invoice;
    }
    
    public static ArrayList<Map<String, String>> getBookInvoice(int id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT books.id, books.name, books.slug, book_invoice.quantity as invoice_quantity, book_invoice.invoice_price FROM books LEFT JOIN book_invoice ON books.id = book_invoice.book_id WHERE invoice_id = ? ";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        ArrayList<Map<String, String>> list = new ArrayList<>();
        while(rs.next()) {
            Map<String, String> book = new HashMap<String, String>();
            book.put("id", rs.getString("id"));
            book.put("name", rs.getString("name")); 
            book.put("slug", rs.getString("slug")); 
            book.put("invoice_quantity", rs.getString("invoice_quantity")); 
            book.put("invoice_price", rs.getString("invoice_price")); 
            list.add(book);
        }
        return list;
    }
    
    public static ArrayList<Invoice> findByUser(int id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM invoices WHERE user_id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        ArrayList<Invoice> list = new ArrayList<>();
        while(rs.next()) {
            Invoice invoice = new Invoice();
            invoice.setId(rs.getInt("id"));
            invoice.setUser_id(rs.getInt("user_id"));
            invoice.setStatus(rs.getInt("status"));
            invoice.setTotal(rs.getInt("total"));
            invoice.setTotal_book(rs.getInt("total_book"));
            invoice.setShip_tax(rs.getInt("ship_tax"));
            invoice.setNote(rs.getString("note"));
            invoice.setAddress(rs.getString("address"));
            invoice.setCreated_at(rs.getString("created_at"));
            invoice.setUpdated_at(rs.getString("updated_at"));
            list.add(invoice);
        }
        return list;
    }
    
    public static void update(Invoice invoice) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE invoices SET user_id=?,status=?,total=?,total_book=?,note=?,ship_tax=?,address=?,updated_at=now() WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, invoice.getUser_id());
        ps.setInt(2, invoice.getStatus());
        ps.setInt(3, invoice.getTotal());
        ps.setInt(4, invoice.getTotal_book());
        ps.setNString(5, invoice.getNote());
        ps.setInt(6, invoice.getShip_tax());
        ps.setNString(7, invoice.getAddress());
        ps.setInt(8, invoice.getId());
        ps.executeUpdate();
    }
    
    public static User user(Invoice invoice) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, invoice.getUser_id());
        ResultSet rs = ps.executeQuery();
        User user = new User();
        if(rs.first()) {
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getInt("role"));
            user.setPassword(rs.getString("password"));
            user.setAddress(rs.getString("address"));
            user.setCreated_at(rs.getString("created_at"));
            user.setUpdated_at(rs.getString("updated_at"));
        }
        return user;
    }
    
    public static void main(String[] args) throws SQLException 
    {
        // 
    }
}
