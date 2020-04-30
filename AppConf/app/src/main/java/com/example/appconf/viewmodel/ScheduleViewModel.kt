package com.example.appconf.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.appconf.model.Conference
import com.example.appconf.network.Callback
import com.example.appconf.network.FirestoreService
import java.lang.Exception

class ScheduleViewModel : ViewModel() {
    val firestoreService = FirestoreService()
    var listaSchedule: MutableLiveData<List<Conference>> = MutableLiveData()
    var isLoading = MutableLiveData<Boolean>()

    fun refresh(){
        getScheduleFromFirebase()
    }

    fun getScheduleFromFirebase(){
        firestoreService.getSchedules(object: Callback<List<Conference>>{
            override fun onSuccess(result: List<Conference>?) {
                listaSchedule.postValue(result)
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