/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.edu.upeu.ventas.daoimp;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import pe.edu.upeu.ventas.dao.PersonaDao;
import pe.edu.upeu.ventas.entity.Persona;
import pe.edu.upeu.ventas.util.Conexion;

/**
 *
 * @author alum.fial1
 */
public class PersonalDaoImp implements PersonaDao{
     private CallableStatement cst;
    private ResultSet rs;
    private Connection cx = Conexion.getConexion();
    private int res = 0;
    @Override
    public int create(Persona p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int update(Persona p) {
      try {
            cst = cx.prepareCall("{call updatePersona(?,?,?,?)}");
            cst.setInt(1, p.getIdpersona());
            cst.setString(2, p.getNombres());
            cst.setString(3, p.getApellidos());
            cst.setString(4, p.getClave());
            
            res = cst.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error : " + e);
        }
        return res;    
    }

    @Override
    public int delete(int key) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Persona read(int key) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Persona> readAll(String dni) {
        List<Persona> lista = new ArrayList<>();
        try {
            cx = Conexion.getConexion();
            cst = cx.prepareCall("{call bdventas.listarPersona2(?)}");
            cst.setString(1, dni);
            rs = cst.executeQuery();
            while(rs.next()){
                Persona p = new Persona();
                p.setIdpersona(rs.getInt("idpersona"));
                p.setNombres(rs.getString("nombres"));
                p.setApellidos(rs.getString("apellidos"));
                p.setDni(rs.getString("dni"));
                p.setTelefono(rs.getString("telefono"));
                lista.add(p);
            }
        } catch (SQLException e) {
            System.out.println("Error:"+e);
        }
        return lista;
    }

    @Override
    public List<Persona> readAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
