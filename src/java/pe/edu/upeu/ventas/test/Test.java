/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.edu.upeu.ventas.test;

import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import pe.edu.upeu.ventas.dao.PersonaDao;
import pe.edu.upeu.ventas.dao.ProductoDao;
import pe.edu.upeu.ventas.dao.RolDao;
import pe.edu.upeu.ventas.dao.UsuarioDao;
import pe.edu.upeu.ventas.dao.VentasDao;
import pe.edu.upeu.ventas.daoimp.PersonalDaoImp;
import pe.edu.upeu.ventas.daoimp.ProductoDaoImp;
import pe.edu.upeu.ventas.daoimp.RolDaoImp;
import pe.edu.upeu.ventas.daoimp.UsuarioDaoImp;
import pe.edu.upeu.ventas.daoimp.VentaslDaoImp;
import pe.edu.upeu.ventas.entity.Persona;
import pe.edu.upeu.ventas.entity.Rol;
import pe.edu.upeu.ventas.entity.Ventas;

/**
 *
 * @author alum.fial1
 */
public class Test {
static Gson g = new Gson();
static RolDao rd = new RolDaoImp();
static UsuarioDao ud = new UsuarioDaoImp();
static ProductoDao pd = new ProductoDaoImp();
static VentasDao vd = new VentaslDaoImp();
static PersonaDao dd = new PersonalDaoImp();
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        //listar();
        //crear();
        per();
        //prod();
        //isertV();
    }
    static void listar(){
        System.out.println(g.toJson(rd.readAll()));
    }
    static void crear(){
        Rol x = new Rol("Gerente de Servicios");
      if(rd.create(x)>0){
          System.out.println("si");
      }else{
          System.out.println("no");
      }
    }
    static void id(){
        System.out.println(g.toJson(rd.read(4)));
    }
    static void user(){
     HashMap<String, Object> data = new HashMap<>();
     data = ud.validar("emilyc", "123");
     System.out.println(data);
        System.out.println(data.size());   
     /*
     Iterator it = data.entrySet().iterator();
     while (it.hasNext()) {
        Map.Entry e = (Map.Entry)it.next();
         System.out.println(e.getKey() + "=" + e.getValue());
     }*/
    }
    static void prod(){
        System.out.println(g.toJson(pd.buscarProductoCodigo(101)));
    }
    static void isertV(){
        Ventas v = new Ventas(2, 5);
        System.out.println(vd.create(v));
    }
    static void per(){
        
        System.out.println(g.toJson(dd.readAll("47474747")));
    }
}
