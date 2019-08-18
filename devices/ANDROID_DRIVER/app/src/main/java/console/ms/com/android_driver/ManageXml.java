package console.ms.com.android_driver;

import android.util.Xml;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;
import org.xmlpull.v1.XmlSerializer;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;

public class ManageXml {

    private InputStream ist;
    private FileOutputStream ost;
    private XmlPullParser xrp;

    // frontend_info
    private String devicename;
    public String get_devicename() { return devicename; }
    public void set_devicename(String p_devicename) { this.devicename = p_devicename; }
    private String autoupdate;
    public String get_autoupdate() { return this.autoupdate; }
    public void set_autoupdate(String p_autoupdate) { this.autoupdate = p_autoupdate; }

    private String timeupdate;
    public String get_timeupdate() { return this.timeupdate; }
    public void set_timeupdate(String p_timeupdate) { this.timeupdate = p_timeupdate; }



    // backend_info
    private String log_record;

    // app_info
    private String app_permission_write;
    private String app_permission_read;
    public boolean get_app_permission_write(){
        boolean result=false;
        if (app_permission_write.equals("true"))
            result=true;
        return result;
    }

    public void set_app_permission_write(boolean value){
        String strValue="false";
        if(value)
            strValue="true";
        app_permission_write=strValue;
    }

    public void set_app_permission_read(boolean value){
        String strValue="false";
        if(value)
            strValue="true";
        app_permission_read=strValue;

    }

    public boolean get_app_permission_read(){
        boolean result=false;
        if (app_permission_write.equals("true"))
            result=true;
        return result;
    }

    public ManageXml(File file){
        devicename ="ADTW";
        timeupdate="false";
        autoupdate="5000";
        log_record="";
        app_permission_write="false";
        app_permission_read="false";
        boolean newFile=false;
        try {
            if (file.exists()){
                InputStream  is = new FileInputStream(file);
                setXrp(XmlPullParserFromInputStream(is));
            }
            else{
                file.createNewFile();
                newFile=true;
            }

            setOst(new FileOutputStream(file));
            setIst(new FileInputStream(file));
            if (newFile)
                writeXml();
            readXml();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    public void writeXml() {
        XmlSerializer xmlSerializer = Xml.newSerializer();
        StringWriter writer = new StringWriter();
        try {
            xmlSerializer.setOutput(writer);
            xmlSerializer.startDocument("UTF-8", true);

            xmlSerializer.startTag("", "settings");

            xmlSerializer.startTag("", "frontend_info");

            xmlSerializer.startTag("", "devicename");
            xmlSerializer.attribute("","value", devicename);
            xmlSerializer.endTag("", "devicename");

            xmlSerializer.startTag("", "autoupdate");
            xmlSerializer.attribute("","value", autoupdate);
            xmlSerializer.endTag("", "autoupdate");


            xmlSerializer.startTag("", "timeupdate");
            xmlSerializer.attribute("","value", timeupdate);
            xmlSerializer.endTag("", "timeupdate");

            xmlSerializer.endTag("", "frontend_info");

            xmlSerializer.startTag("", "app_info");

            xmlSerializer.startTag("", "app_permission_write");
            xmlSerializer.attribute("","value", app_permission_write);
            xmlSerializer.endTag("", "app_permission_write");

            xmlSerializer.startTag("", "app_permission_read");
            xmlSerializer.attribute("","value", app_permission_read);
            xmlSerializer.endTag("", "app_permission_read");

            xmlSerializer.endTag("", "app_info");

            xmlSerializer.endTag("", "settings");

            xmlSerializer.endDocument();

            ost.write(writer.toString().getBytes());
            ost.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public void readXml(){
        boolean frontend_info = false;
        boolean app_info = false;

        try {
            int event = xrp.getEventType();
            while (event != XmlPullParser.END_DOCUMENT)  {
                String name=xrp.getName();
                switch (event){
                    case XmlPullParser.START_TAG:
                        if(name.equals("frontend_info"))
                            frontend_info = true;
                        if(name.equals("app_info"))
                            app_info = true;
                        if (name.equals("devicename")&& frontend_info)
                            devicename =xrp.getAttributeValue(0);
                        if (name.equals("autoupdate")&& frontend_info)
                            autoupdate=xrp.getAttributeValue(0);
                        if (name.equals("timeupdate")&& frontend_info)
                            timeupdate=xrp.getAttributeValue(0);
                        if (name.equals("app_permission_write")&& app_info)
                            app_permission_write=xrp.getAttributeValue(0);
                        if (name.equals("app_permission_read")&& app_info)
                            app_permission_read=xrp.getAttributeValue(0);
                        break;
                }
                event = xrp.next();
            }
        } catch (XmlPullParserException | IOException e) {
            e.printStackTrace();
        }
    }

    public XmlPullParser XmlPullParserFromInputStream(InputStream input)
    {
        XmlPullParser xpp = null;
        try {
            XmlPullParserFactory xppf = XmlPullParserFactory.newInstance();
            xpp = xppf.newPullParser();
            xpp.setInput(input,null);

        } catch (XmlPullParserException e) {
            e.printStackTrace();
        }
        finally {
            return xpp;
        }

    }

    public void setXrp(XmlPullParser xrp) {
        this.xrp = xrp;
    }

    public void setIst(InputStream ist) {
        this.ist = ist;
    }

    public void setOst(FileOutputStream ost) {
        this.ost = ost;
    }


}