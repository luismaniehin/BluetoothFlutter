package com.example.appconf.view.ui.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.os.bundleOf
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager

import com.example.appconf.R
import com.example.appconf.model.Speaker
import com.example.appconf.view.adapter.SpeakersAdapter
import com.example.appconf.view.adapter.SpeakersListener
import com.example.appconf.viewmodel.SpeakersViewModel
import kotlinx.android.synthetic.main.fragment_speakers.*

class SpeakersFragment : Fragment(), SpeakersListener {

    private lateinit var speakersAdapter: SpeakersAdapter
    private lateinit var speakersViewModel: SpeakersViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_speakers, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        speakersViewModel = ViewModelProviders.of(this).get(SpeakersViewModel::class.java)
        speakersViewModel.refresh()

        speakersAdapter = SpeakersAdapter(this)

        rvSpeakers.apply {
            layoutManager = GridLayoutManager(view.context, 2)
            adapter = speakersAdapter
        }

        observeViewModel()
    }

    fun observeViewModel() {
        speakersViewModel.listaSpeakers.observe(this, Observer<List<Speaker>> { speaker ->
            speakersAdapter.updateData(speaker)
        })

        speakersViewModel.isLoading.observe(this, Observer<Boolean> {
            if(it != null)
                rlBase.visibility = View.INVISIBLE
        })
    }

    override fun onSpeakerClicked(speaker: Speaker, position: Int) {
        val bundle = bundleOf("speaker" to speaker)
        findNavController().navigate(R.id.speakersDetailFragmentDialog, bundle)
    }

}
