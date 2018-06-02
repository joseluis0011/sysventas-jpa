/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.edu.upeu.ventas.entity;

/**
 *
 * @author alum.fial1
 */
public class Persona {
    private int idpersona;
    private String nombres;
    private String apellidos;
    private String dni;
    private String telefono;
    private String clave;
    
    public Persona() {
    }
    
    public Persona(int idpersona, String nombres, String apellidos, String clave) {        
        this.idpersona = idpersona;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.clave = clave;        
    }
    public Persona(String nombres, String apellidos, String dni, String telefono) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.dni = dni;
        this.telefono = telefono;
    }

    public Persona(int idpersona, String nombres, String apellidos, String dni, String telefono) {
        this.idpersona = idpersona;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.dni = dni;
        this.telefono = telefono;
    }

    public int getIdpersona() {
        return idpersona;
    }

    public void setIdpersona(int idpersona) {
        this.idpersona = idpersona;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }
    
    
}
