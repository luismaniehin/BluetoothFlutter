package com.example.appconf.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.appconf.R
import com.example.appconf.model.Conference
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.ArrayList

class ScheduleAdapter(val scheduleListener: ScheduleListener) : RecyclerView.Adapter<ScheduleAdapter.ViewHolder>() {
    var listaConference = ArrayList<Conference>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_schedule, parent, false))

    override fun getItemCount() = listaConference.size

    override fun onBindViewHolder(holder: ScheduleAdapter.ViewHolder, position: Int) {
        val confe: Conference = listaConference[position] as Conference

        holder.tvConfName.text = confe.title
        holder.tvConfSpeaker.text = confe.speaker
        holder.tvConfTag.text = confe.tag

        val simpleDateFormat = SimpleDateFormat("HH:mm")
        val simpleDateFormatTime = SimpleDateFormat("a")
        val calendar = Calendar.getInstance()
        calendar.time = confe.datetime
        val hour = simpleDateFormat.format(confe.datetime)

        holder.tvConfHour.text = hour
        holder.tvConfTime.text = simpleDateFormatTime.format(confe.datetime).toUpperCase()

        holder.itemView.setOnClickListener {
            scheduleListener.onConferenceClicked(confe, position)
        }
    }

    fun updateData(data: List<Conference>) {
        listaConference.clear()
        listaConference.addAll(data)
        notifyDataSetChanged()
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val tvConfName = itemView.findViewById<TextView>(R.id.tvItemScheduleNameConference)
        val tvConfSpeaker = itemView.findViewById<TextView>(R.id.tvItemScheduleSpeakerConference)
        val tvConfTag = itemView.findViewById<TextView>(R.id.tvItemScheduleTagConference)
        val tvConfHour = itemView.findViewById<TextView>(R.id.tvItemScheduleHour)
        val tvConfTime = itemView.findViewById<TextView>(R.id.tvItemScheduleTime)
    }
}