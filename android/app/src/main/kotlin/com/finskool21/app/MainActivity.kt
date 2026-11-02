package com.finskool21.app

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // The app shows invoices, P&L and billing details, so nothing on screen
        // may be captured. FLAG_SECURE makes the system refuse screenshots,
        // blank screen recordings and casting, and hide the app's card in the
        // recents list. Set before the first frame so there is no window of
        // exposure. To allow screenshots (e.g. for store listings), remove it.
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE,
        )
        super.onCreate(savedInstanceState)
    }
}
