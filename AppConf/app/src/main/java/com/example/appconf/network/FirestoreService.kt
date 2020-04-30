package com.example.appconf.network

import com.example.appconf.model.Conference
import com.example.appconf.model.Speaker
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.FirebaseFirestoreSettings

const val CONFERENCES_COLLECTION = "conferences"
const val SPEAKERS_COLLECTION = "speakers"

class FirestoreService {
    val firebaseFirestore = FirebaseFirestore.getInstance()
    val settings = FirebaseFirestoreSettings.Builder().setPersistenceEnabled(true).build()

    init {
        firebaseFirestore.firestoreSettings = settings
    }

    fun getSpeakers(callback: Callback<List<Speaker>>){
        //firebaseFirestore.collection("conferences")
        firebaseFirestore.collection(SPEAKERS_COLLECTION)
            .orderBy("category")
            .get()
            .addOnSuccessListener { result ->
                for(doc in result){
                    val lista = result.toObjects(Speaker::class.java)
                    callback.onSuccess(lista)
                    break
                }
            }
    }

    fun getSchedules(callback: Callback<List<Conference>>){
        firebaseFirestore.collection(CONFERENCES_COLLECTION)
            .get()
            .addOnSuccessListener { result ->
                for(doc in result){
                    val lista = result.toObjects(Conference::class.java)
                    callback.onSuccess(lista)
                    break
                }
            }
    }
}