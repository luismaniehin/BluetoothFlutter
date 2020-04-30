package com.example.appconf.view.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.example.appconf.R
import com.example.appconf.model.Speaker
import kotlin.collections.ArrayList

class SpeakersAdapter(val speakersListener: SpeakersListener) : RecyclerView.Adapter<SpeakersAdapter.ViewHolder>() {
    var listaSpeakers = ArrayList<Speaker>()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_speaker, parent, false))

    override fun getItemCount() = listaSpeakers.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val speaker = listaSpeakers[position]

        holder.tvSpeakerName.text = speaker.name
        holder.tvSpeakerWork.text = speaker.workplace

        Glide.with(holder.itemView.context)
            .load(speaker.image)
            .apply(RequestOptions.circleCropTransform())
            .into(holder.ivSpeakerImage)

        holder.itemView.setOnClickListener {
            speakersListener.onSpeakerClicked(speaker, position)
        }
    }

    fun updateData(data: List<Speaker>) {
        listaSpeakers.clear()
        listaSpeakers.addAll(data)
        notifyDataSetChanged()
    }

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val tvSpeakerName = itemView.findViewById<TextView>(R.id.tvItemSpeakerName)
        val tvSpeakerWork = itemView.findViewById<TextView>(R.id.tvItemSpeakerWork)
        val ivSpeakerImage = itemView.findViewById<ImageView>(R.id.ivItemSpeakerImage)
    }
}