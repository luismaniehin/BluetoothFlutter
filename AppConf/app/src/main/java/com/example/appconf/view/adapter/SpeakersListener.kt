package com.example.appconf.view.adapter

import com.example.appconf.model.Speaker

interface SpeakersListener {
    fun onSpeakerClicked(speaker: Speaker, position: Int)
}