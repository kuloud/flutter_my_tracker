package com.kuloud.android.flit

import android.app.Application
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import com.gyf.cactus.ext.cactus
import com.gyf.cactus.ext.cactusUnregister
import yukams.app.background_locator.Keys

/**
 * @author kuloud
 * @date 2023/11/5
 */
class FloveApp : Application() {
    override fun onCreate() {
        super.onCreate()
        val intent = Intent(this, getMainActivityClass(this))
        intent.action = Keys.NOTIFICATION_ACTION

        val pendingIntent: PendingIntent = PendingIntent.getActivity(
            this,
            1, intent, PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
        cactus {
            isDebug(true)
            setPendingIntent(pendingIntent)
            setChannelId(Keys.CHANNEL_ID)
            setChannelName(getString(R.string.app_name))
            setTitle(getString(R.string.app_name))
            setContent(getString(R.string.app_is_running))
        }
        
    }

    private fun getMainActivityClass(context: Context): Class<*>? {
        val packageName = context.packageName
        val launchIntent = context.packageManager.getLaunchIntentForPackage(packageName)
        val className = launchIntent?.component?.className ?: return null

        return try {
            Class.forName(className)
        } catch (e: ClassNotFoundException) {
            e.printStackTrace()
            null
        }
    }
}