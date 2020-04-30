package com.example.appconf.view.ui.fragments

import android.graphics.Color
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.fragment.app.DialogFragment

import com.example.appconf.R
import com.example.appconf.model.Conference
import kotlinx.android.synthetic.main.fragment_schedule_detail_dialog.*
import java.text.SimpleDateFormat

class ScheduleDetailDialogFragment : DialogFragment() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NORMAL, R.style.fullScreenDialogStyle)
    }

    override fun onStart() {
        super.onStart()
        dialog?.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_schedule_detail_dialog, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        toolbarConf.navigationIcon = ContextCompat.getDrawable(view.context, R.drawable.ic_close)
        toolbarConf.setTitleTextColor(Color.WHITE)
        toolbarConf.setNavigationOnClickListener{
            dismiss()
        }

        val conference = arguments?.getSerializable("conference") as Conference

        toolbarConf.title = conference.title

        tvTituloConf.text = conference.title

        val pattern = "dd/MM/yyyy hh:mm a"
        val simpleDF = SimpleDateFormat(pattern)
        val date = simpleDF.format(conference.datetime)

        tvDetailConfHour.text = date
        tvDetailConfSpeaker.text = conference.speaker
        tvDetailConfTag.text = conference.tag
        tvDetailConfDescription.text = conference.description
    }

}
