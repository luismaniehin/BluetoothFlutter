package com.example.appconf.view.adapter

import com.example.appconf.model.Conference

interface ScheduleListener {
    fun onConferenceClicked(conference: Conference, position: Int)
}