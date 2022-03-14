package org.ossiaustria.amigoapp

import android.content.Intent

import android.content.Intent.getIntent

import android.os.Bundle
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private var argumentsMap: Map<String, Object>? = null

    // boring copy of AmigoCloudEvent
    private var receiver_id: String = ""
    private var action: String = ""
    private var entity_id: String = ""
    private var type: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // map intent data to variables
        receiver_id = intent?.getStringExtra("receiver_id") ?: ""
        action = intent?.getStringExtra("action") ?: ""
        type = intent?.getStringExtra("type") ?: ""
        entity_id = intent?.getStringExtra("entity_id") ?: ""
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.getDartExecutor().getBinaryMessenger(),
            "amigoapp.channel.shared.data"
        ).setMethodCallHandler { call, result ->
            if (call.method.contentEquals("amigoCloudEventData")) {
                result.success(
                    mapOf(
                        "receiver_id" to receiver_id,
                        "action" to action,
                        "entity_id" to entity_id,
                        "type" to type
                    )
                )
            }
        }
    }
}
