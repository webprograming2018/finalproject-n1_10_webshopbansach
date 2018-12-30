/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnection;
import Model.Book;
import Model.Category;
import Model.Invoice;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author mito
 */
public class DAOUser {
    public static ArrayList<User> getListUser() throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM users";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<User> list = new ArrayList<>();
        while(rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getInt("role"));
            user.setAddress(rs.getString("address"));
            user.setPassword(rs.getString("password"));
            user.setCreated_at(rs.getString("created_at"));
            user.setUpdated_at(rs.getString("updated_at"));
            user.setDeleted_at(rs.getString("deleted_at"));
            list.add(user);
        }
        return list;
    }
    
    public static User find(int id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, id);
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
            user.setDeleted_at(rs.getString("deleted_at"));
        }
        return user;
    }

    public ArrayList<User> getUserByCon(String con) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM users " + con;
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<User> list = new ArrayList<>();
        while(rs.next()) {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setRole(rs.getInt("role"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setAddress(rs.getString("address"));
            user.setCreated_at(rs.getString("created_at"));
            user.setUpdated_at(rs.getString("updated_at"));
            user.setDeleted_at(rs.getString("deleted_at"));
            list.add(user);
        }
        return list;
    }
    
    public static void save(User user) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        if(user.getRole() == 0) {
            user.setRole(2);
        }
        String sql = "INSERT INTO users(username, email, password, role, address) VALUES(?,?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, user.getUsername());
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPassword());
        ps.setInt(4, user.getRole());
        ps.setNString(5, user.getAddress());
        ps.executeUpdate();
    }
    
    public static void update(User user) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE users SET username=?, email=?,password=?,role=?,address=?,updated_at=now() WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setNString(1, user.getUsername());
        ps.setNString(2, user.getEmail());
        ps.setNString(3, user.getPassword());
        ps.setInt(4, user.getRole());
        ps.setNString(5, user.getAddress());
        ps.setInt(6, user.getId());
        ps.executeUpdate();
    }
    
    public static void addToFavorite(int user_id, int cat_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "INSERT INTO favorites(user_id, cat_id) VALUES(?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, user_id);
        ps.setInt(2, cat_id);
        ps.executeUpdate();
    }
    
    public static void removeFavorite(int user_id, int cat_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "DELETE FROM favorites WHERE user_id = ? AND cat_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, user_id);
        ps.setInt(2, cat_id);
        ps.executeUpdate();
    }
    
    public static boolean checkFavorite(int user_id, int cat_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM favorites WHERE user_id=? AND cat_id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, user_id);
        ps.setInt(2, cat_id);
        ResultSet rs = ps.executeQuery();
        return rs.first();
    }

    public static ArrayList<Category> favorites(User user) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT DISTINCT categories.* FROM favorites LEFT JOIN categories ON favorites.cat_id = categories.id WHERE favorites.user_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, user.getId());
        ResultSet rs = ps.executeQuery();
        ArrayList<Category> list = new ArrayList<>();
        while(rs.next()) {
            Category category = new Category();
            category.setId(rs.getInt("id"));
            category.setName(rs.getString("name"));
            category.setCreated_at(rs.getString("created_at"));
            category.setUpdated_at(rs.getString("updated_at"));
            category.setDeleted_at(rs.getString("deleted_at"));
            list.add(category);
        }
        return list;
    }
    
    public static ArrayList<Invoice> invoices(User user) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT invoices.* FROM invoices LEFT JOIN users ON users.id = invoices.user_id WHERE invoices.user_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, user.getId());
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
    
    public static void delete(int user_id) throws SQLException 
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE users SET deleted_at=CURRENT_TIMESTAMP() WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, user_id);
        ps.executeUpdate();
    }
    
    public static void restore(int user_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE users SET deleted_at=NULL WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, user_id);
        ps.executeUpdate();
    }
    
    public static void main(String[] args) throws SQLException 
    {
        User user = DAOUser.find(13);
        String password = "1234";
        if(BCrypt.checkpw(password, user.getPassword())) {
            System.out.print("ok");
        }
    }
}
