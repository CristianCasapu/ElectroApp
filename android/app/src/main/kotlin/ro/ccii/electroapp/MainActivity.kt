package ro.ccii.electroapp

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.ContactsContract
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Canalul nativ al aplicației: selectorul de contact și datele dispozitivului
 * (marcă, model, versiune Android) pentru antetul jurnalului de depanare.
 *
 * Selectorul de contact funcționează FĂRĂ permisiunea READ_CONTACTS: ACTION_PICK deschide
 * agenda sistemului, iar Android acordă acces temporar doar la contactul ales.
 * Din acel URI citim numele, telefoanele, e-mailurile și adresele poștale
 * prin directorul `Contacts.Entity` (acoperit de aceeași permisiune temporară).
 */
class MainActivity : FlutterActivity() {
    private val canal = "ro.ccii.electroapp/contacte"
    private val codCerere = 4711
    private var rezultatInAsteptare: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, canal).setMethodCallHandler { call, result ->
            when (call.method) {
                "alegeContact" -> {
                    if (rezultatInAsteptare != null) {
                        result.error("ocupat", "Un selector este deja deschis", null)
                        return@setMethodCallHandler
                    }
                    rezultatInAsteptare = result
                    try {
                        val intent = Intent(Intent.ACTION_PICK, ContactsContract.Contacts.CONTENT_URI)
                        startActivityForResult(intent, codCerere)
                    } catch (e: Exception) {
                        rezultatInAsteptare = null
                        result.error("indisponibil", "Agenda de contacte nu e disponibilă", null)
                    }
                }
                "infoDispozitiv" -> result.success(
                    mapOf(
                        "marca" to android.os.Build.MANUFACTURER,
                        "model" to android.os.Build.MODEL,
                        "android" to android.os.Build.VERSION.RELEASE,
                        "api" to android.os.Build.VERSION.SDK_INT
                    )
                )
                else -> result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != codCerere) return
        val result = rezultatInAsteptare ?: return
        rezultatInAsteptare = null
        val uri = data?.data
        if (resultCode != Activity.RESULT_OK || uri == null) {
            result.success(null)
            return
        }
        result.success(citesteContact(uri))
    }

    private fun citesteContact(uri: Uri): Map<String, Any?> {
        var nume = ""
        val telefoane = mutableListOf<String>()
        val emailuri = mutableListOf<String>()
        val adrese = mutableListOf<String>()

        try {
            contentResolver.query(
                uri, arrayOf(ContactsContract.Contacts.DISPLAY_NAME), null, null, null
            )?.use { c -> if (c.moveToFirst()) nume = c.getString(0) ?: "" }
        } catch (_: Exception) {
        }

        try {
            val entitati = Uri.withAppendedPath(uri, ContactsContract.Contacts.Entity.CONTENT_DIRECTORY)
            contentResolver.query(
                entitati,
                arrayOf(
                    ContactsContract.Contacts.Entity.MIMETYPE,
                    ContactsContract.Contacts.Entity.DATA1
                ),
                null, null, null
            )?.use { c ->
                val iMime = c.getColumnIndex(ContactsContract.Contacts.Entity.MIMETYPE)
                val iData = c.getColumnIndex(ContactsContract.Contacts.Entity.DATA1)
                while (c.moveToNext()) {
                    val mime = c.getString(iMime) ?: continue
                    val valoare = c.getString(iData)?.trim().orEmpty()
                    if (valoare.isEmpty()) continue
                    when (mime) {
                        ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE ->
                            if (valoare !in telefoane) telefoane += valoare
                        ContactsContract.CommonDataKinds.Email.CONTENT_ITEM_TYPE ->
                            if (valoare !in emailuri) emailuri += valoare
                        ContactsContract.CommonDataKinds.StructuredPostal.CONTENT_ITEM_TYPE ->
                            if (valoare !in adrese) adrese += valoare.replace('\n', ',')
                    }
                }
            }
        } catch (_: Exception) {
            // fără acces la detalii: rămânem cu numele
        }

        return mapOf(
            "nume" to nume,
            "telefoane" to telefoane,
            "emailuri" to emailuri,
            "adrese" to adrese
        )
    }
}
