/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnection;
import Model.Book;
import Model.Invoice;
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
public class DAOBook {
    public static ArrayList<Map<String, String>> getListBook() throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT books.*, categories.name as cat_name FROM books LEFT JOIN categories ON categories.id = books.cat_id";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Map<String, String>> list = new ArrayList<>();
        while(rs.next()) {
            Map<String, String> book = new HashMap<String, String>();
            book.put("id", rs.getString("id"));
            book.put("name", rs.getString("name")); 
            book.put("author", rs.getString("author")); 
            book.put("cat_name", rs.getString("cat_name"));
            book.put("total_quantity", rs.getString("total_quantity"));
            book.put("left_quantity", rs.getString("left_quantity"));
            book.put("created_at", rs.getString("created_at")); 
            book.put("deleted_at", rs.getString("deleted_at"));
            list.add(book);
        }
        return list;
    }
    
    public static ArrayList<Book> getBookForImport() throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM books";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Book> list = new ArrayList<>();
        while(rs.next()) {
            Book book = new Book();
            book.setId(rs.getInt("id"));
            book.setName(rs.getString("name"));
            book.setSlug(rs.getString("slug"));
            book.setAuthor(rs.getString("author"));
            book.setDes(rs.getString("des"));
            book.setCat_id(rs.getInt("cat_id"));
            book.setPrice(rs.getInt("price"));
            book.setTotal_quantity(rs.getInt("total_quantity"));
            book.setLeft_quantity(rs.getInt("left_quantity"));
            book.setCreated_at(rs.getString("created_at"));
            book.setUpdated_at(rs.getString("updated_at"));
            book.setDeleted_at(rs.getString("deleted_at"));
            list.add(book);
        }
        return list;
    }
    
    public static ArrayList<Book> getBookByCon(String con) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM books " + con;
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Book> list = new ArrayList<>();
        while(rs.next()) {
            Book book = new Book();
            book.setId(rs.getInt("id"));
            book.setName(rs.getString("name"));
            book.setSlug(rs.getString("slug"));
            book.setAuthor(rs.getString("author"));
            book.setDes(rs.getString("des"));
            book.setCat_id(rs.getInt("cat_id"));
            book.setPrice(rs.getInt("price"));
            book.setTotal_quantity(rs.getInt("total_quantity"));
            book.setLeft_quantity(rs.getInt("left_quantity"));
            book.setCreated_at(rs.getString("created_at"));
            book.setUpdated_at(rs.getString("updated_at"));
            book.setDeleted_at(rs.getString("deleted_at"));
            list.add(book);
        }
        return list;
    }

    public static Book findBook(int id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM books WHERE id =?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Book book = new Book();
        if (rs.first()) {
            book.setId(rs.getInt("id"));
            book.setName(rs.getString("name"));
            book.setSlug(rs.getString("slug"));
            book.setAuthor(rs.getString("author"));
            book.setDes(rs.getString("des"));
            book.setCat_id(rs.getInt("cat_id"));
            book.setPrice(rs.getInt("price"));
            book.setTotal_quantity(rs.getInt("total_quantity"));
            book.setLeft_quantity(rs.getInt("left_quantity"));
            book.setCreated_at(rs.getString("created_at"));
            book.setUpdated_at(rs.getString("updated_at"));
            book.setDeleted_at(rs.getString("deleted_at"));
        }
        return book;
    }

    public static void save(Book book) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "INSERT INTO books(name, author, des, cat_id, total_quantity, left_quantity, price, slug) VALUES(?,?,?,?,?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setNString(1, book.getName());
        ps.setNString(2, book.getAuthor());
        ps.setNString(3, book.getDes());
        ps.setInt(4, book.getCat_id());
        ps.setInt(5, book.getTotal_quantity());
        ps.setInt(6, book.getLeft_quantity());
        ps.setInt(7, book.getPrice());
        ps.setNString(8, book.getSlug());
        ps.executeUpdate();
    }

    public static void update(Book book) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE books SET name=?,author=?,des=?,cat_id=?,total_quantity=?,left_quantity=?,price=?,slug=?,updated_at=now(),deleted_at=? WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setNString(1, book.getName());
        ps.setNString(2, book.getAuthor());
        ps.setNString(3, book.getDes());
        ps.setInt(4, book.getCat_id());
        ps.setInt(5, book.getTotal_quantity());
        ps.setInt(6, book.getLeft_quantity());
        ps.setInt(7, book.getPrice());
        ps.setNString(8, book.getSlug());
        ps.setNString(9, book.getDeleted_at());
        ps.setInt(10, book.getId());
        ps.executeUpdate();
    }
    
    public static ArrayList<Invoice> invoices(Book book) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT invoices.* FROM invoices LEFT JOIN book_invoice ON invoices.id = book_invoice.invoice_id LEFT JOIN books ON books.id = book_invoice.book_id WHERE books.id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, book.getId());
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
    
    public static void delete(int book_id) throws SQLException 
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE books SET deleted_at=CURRENT_TIMESTAMP() WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, book_id);
        ps.executeUpdate();
    }
    
    public static void restore(int book_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE books SET deleted_at=NULL WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, book_id);
        ps.executeUpdate();
    }
    
    public static void main(String[] args) throws SQLException 
    {
        Book book = DAOBook.findBook(12);
        for(Invoice inv : DAOBook.invoices(book)) {
            System.out.println(inv.getId());
        }
    }

    
}
