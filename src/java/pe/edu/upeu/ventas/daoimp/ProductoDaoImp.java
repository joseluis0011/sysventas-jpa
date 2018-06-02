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
import pe.edu.upeu.ventas.dao.ProductoDao;
import pe.edu.upeu.ventas.entity.Producto;
import pe.edu.upeu.ventas.util.Conexion;

/**
 *
 * @author alum.fial1
 */
public class ProductoDaoImp implements ProductoDao{
    private CallableStatement cst;
    private ResultSet rs;
    private Connection cx;
    @Override
    public Producto buscarProductoCodigo(int cod) {
        Producto p = new Producto();
        try {
            cx = Conexion.getConexion();
            cst = cx.prepareCall("{call buscarPorductoCodigo(?)}");
            cst.setInt(1, cod);
            rs = cst.executeQuery();
            while(rs.next()){
                p.setIdprod(rs.getInt("idproducto"));
                p.setNomprod(rs.getString("nom_prod"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
                p.setCod(rs.getInt("codigo"));
            }
        } catch (SQLException e) {
            System.out.println("Error: "+e);
        }
        return p;
    }
    
}
