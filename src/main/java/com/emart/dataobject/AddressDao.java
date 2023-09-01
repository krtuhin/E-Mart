package com.emart.dataobject;

import com.emart.entities.Address;
import com.emart.helper.FactoryProvider;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class AddressDao {

    //fetch session factory
    private SessionFactory factory = FactoryProvider.getFactory();

    //method for save address into database
    public int saveAddress(Address address) {

        //create hibernate session and transaction
        Session s = factory.openSession();
        Transaction tx = s.beginTransaction();

        //save data
        int id = (int) s.save(address);

        //commit transaction to permanent save data into database and close sesion
        tx.commit();
        s.close();

        return id;
    }

    //method for get all address from database using user id
    public List<Address> getAllAddressByUserId(int userId) {

        //create session
        Session s = factory.openSession();

        //dynamically fetch data from address database using userId
        Query query = s.createQuery("from Address where userId=:x").setParameter("x", userId);

        List<Address> addressList = query.getResultList();

        s.close();

        return addressList;
    }

    //method for delete address
    public void deleteAddressById(int addressId) {

        //hibernate session
        Session s = factory.openSession();
        Transaction tx = s.beginTransaction();

        //query for delete address
        Query query = s.createQuery("delete from Address where id=:x").setParameter("x", addressId);
        query.executeUpdate();

        tx.commit();
        s.close();
    }

    //method for get single address by address id
    public Address getAddressById(int addressId) {

        Session s = factory.openSession();

        Address address = s.get(Address.class, addressId);

        s.close();

        return address;
    }
}
