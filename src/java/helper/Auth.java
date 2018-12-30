/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package helper;

import DAO.DAOUser;
import Model.User;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author mito
 */
public class Auth {
    
    public static boolean logged(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return session.getAttribute("username") != null;
    }
    
    public static boolean admin(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return session.getAttribute("username") != null && session.getAttribute("role").equals(1);
    }
    
    public static User current(HttpServletRequest request) throws SQLException {
        HttpSession session = request.getSession();
        int user_id = Integer.parseInt(session.getAttribute("id").toString());
        User user = DAOUser.find(user_id);
        return user;
    }
}
