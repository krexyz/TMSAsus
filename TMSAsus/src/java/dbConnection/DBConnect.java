/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbConnection;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import coreservlets.*;

/**
 *
 * @author Akram
 */
public class DBConnect {

    final static String serverName = "localhost";
    final static String databaseName = "tmsasus";
    
    static String driver;
    static String url;
    
    static Connection con;
    
    public static void loadConnection() {
        String username = "root"; // Username/password required
        String password = ""; // for MSSQL SERVER.
        DriverUtilities.loadDrivers();
        driver = DriverUtilities.getDriver(DriverUtilities.MYSQL);
        url = DriverUtilities.makeURL(serverName, databaseName, DriverUtilities.MYSQL);
        con = null;
        try {
            Class.forName(driver);
            
            con = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
    
    public static void closeConnection(){
        try{
            con.close();
        }
        catch(SQLException sqle) {
            System.err.println("Error connecting: " + sqle);
        }
    }
    
    public static Connection getConnection(){
        return con;
    }
    
    public static ResultSet doQuery(String query){
        ResultSet result = null;
        try{
            PreparedStatement statement = con.prepareStatement(query);
            result = statement.executeQuery();
        }
        catch(SQLException sqle) {
            System.err.println("Error connecting: " + sqle);
            System.err.println("Punca:  " + sqle.toString());
            System.err.println("SQLState:  " + sqle.getSQLState());
            System.err.println("Message:  " + sqle.getMessage());
            System.err.println("Vendor:  " + sqle.getErrorCode());
        }
        
        return result;
    }
    
    public static ResultSet doQuery (PreparedStatement statement){
        ResultSet result = null;
        try{
            result = statement.executeQuery();
        }
        catch(SQLException sqle) {
            System.err.println("Error connecting: " + sqle);
            System.err.println("Punca:  " + sqle.toString());
            System.err.println("SQLState:  " + sqle.getSQLState());
            System.err.println("Message:  " + sqle.getMessage());
            System.err.println("Vendor:  " + sqle.getErrorCode());
        }
        
        return result;
    }
}

  