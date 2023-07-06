package com.emart.dataobject;

import com.emart.entities.Address;
import com.emart.helper.FactoryProvider;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class AddressDao {

    //method for save address into database
    public int saveAddress(Address address) {

        //create hibernate session and transaction
        Session s = FactoryProvider.getFactory().openSession();
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
        Session s = FactoryProvider.getFactory().openSession();

        //dynamically fetch data from address database using userId
        Query query = s.createQuery("from Address where userId=:x").setParameter("x", userId);

        List<Address> addressList = query.getResultList();

        s.close();

        return addressList;
    }

    //method for delete address
    public void deleteAddressById(int addressId) {

        //hibernate session
        Session s = FactoryProvider.getFactory().openSession();
        Transaction tx = s.beginTransaction();

        //query for delete address
        Query query = s.createQuery("delete from Address where id=:x").setParameter("x", addressId);
        query.executeUpdate();

        tx.commit();
        s.close();
    }
}
