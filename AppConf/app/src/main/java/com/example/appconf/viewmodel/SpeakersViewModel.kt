package com.example.appconf.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.appconf.model.Speaker
import com.example.appconf.network.Callback
import com.example.appconf.network.FirestoreService
import java.lang.Exception

class SpeakersViewModel : ViewModel() {
    val firestoreService = FirestoreService()
    var listaSpeakers: MutableLiveData<List<Speaker>> = MutableLiveData()
    var isLoading = MutableLiveData<Boolean>()

    fun refresh(){
        getSpeakersFromFirebase()
    }

    fun getSpeakersFromFirebase(){
        firestoreService.getSpeakers(object: Callback<List<Speaker>> {
            override fun onSuccess(result: List<Speaker>?) {
                listaSpeakers.postValue(result)
                processFinished()
            }

            override fun onFailed(exception: Exception) {
                processFinished()
            }
        })
    }

    fun processFinished() {
        isLoading.value = true
    }
}