package com.example.appconf.model

import java.io.Serializable
import java.util.*

class Conference: Serializable {
    //lateinit --> inicialización tardia
    lateinit var title: String
    lateinit var description: String
    lateinit var tag: String
    lateinit var datetime: Date
    lateinit var speaker: String
}