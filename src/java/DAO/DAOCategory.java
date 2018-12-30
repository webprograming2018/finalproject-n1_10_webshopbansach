/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Database.DBConnection;
import Model.Book;
import Model.Category;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author mito
 */
public class DAOCategory {
    public static ArrayList<Category> getListCategory() throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM categories";
        PreparedStatement ps = connection.prepareCall(sql);
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
    
    public static ArrayList<Category> getListCategoryWithoutDeleted() throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM categories WHERE deleted_at IS NULL";
        PreparedStatement ps = connection.prepareCall(sql);
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

    public static Category find(int id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM categories WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Category cat = new Category();
        if(rs.first()) {
            cat.setId(rs.getInt("id"));
            cat.setName(rs.getString("name"));
            cat.setCreated_at(rs.getString("created_at"));
            cat.setUpdated_at(rs.getString("updated_at"));
            cat.setDeleted_at(rs.getString("deleted_at"));
        }
        return cat;
    }
    
    public static void update(Category cat) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE categories SET name=?,updated_at=now() WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setNString(1, cat.getName());
        ps.setInt(2, cat.getId());
        ps.executeUpdate();
    }
    
    public static void save(Category cat) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "INSERT INTO categories(name) VALUES(?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setNString(1, cat.getName());
        ps.executeUpdate();
    }
    
    public static ArrayList<User> FavoriteUser(int cat_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT DISTINCT users.* FROM users LEFT JOIN favorites ON users.id = favorites.user_id LEFT JOIN categories ON favorites.cat_id = categories.id WHERE categories.id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, cat_id);
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
            list.add(user);
        }
        return list;
    }
    
    public static ArrayList<Book> books(Category cat) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "SELECT * FROM books WHERE cat_id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, cat.getId());
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
    
    public static void delete(int cat_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE categories SET deleted_at=CURRENT_TIMESTAMP() WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, cat_id);
        ps.executeUpdate();
    }
    
    public static void restore(int cat_id) throws SQLException
    {
        Connection connection = DBConnection.getConnection();
        String sql = "UPDATE categories SET deleted_at=NULL WHERE id=?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, cat_id);
        ps.executeUpdate();
    }
    
    public static void main(String[] args) throws SQLException 
    {
        //
    }
}
