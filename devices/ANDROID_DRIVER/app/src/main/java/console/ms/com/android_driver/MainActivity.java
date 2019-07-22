package console.ms.com.android_driver;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.util.Enumeration;

import android.app.Application;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.os.Bundle;


public class MainActivity extends AppCompatActivity  {


    TextView infoLog;



    private static final String TAG_Visible = "Visible";
    private static final String TAG_Server = "Server";

    public String getTAG_Visible()
    {
        return TAG_Visible;
    }
    public String getTAG_Server()
    {
        return TAG_Server;
    }

    /* SERVER */
    private Button bServer;
    private TextView tvServer;
    private TextView tvStatus;
    public Button getbServer() {return bServer; }
    public TextView gettvServer() {return tvServer; }
    public TextView gettvStatus() {return tvStatus; }

    /* SENSOR */
    private TextView[] tvSensori;
    public TextView[] gettvSensori() {return tvSensori; }
    private Button bSensorDim;
    private GridLayout vwSensor;
    public Button getbSensorDim() {return bSensorDim; }
    public GridLayout getVwSensor() {return vwSensor; }

    /* SET */
    private Button bSetDim;
    private GridLayout vwSet;
    private EditText etDeviceName;
    private EditText etTimeUpdate;
    public Button getbSetDim() {return bSetDim; }
    public GridLayout getVwSet() {return vwSet; }
    public EditText getetDeviceName() {return etDeviceName; }
    public EditText getetTimeUpdate() {return etTimeUpdate; }

    /* LOG */
    private Button bLogDim;
    private ScrollView vwLog;
    public Button getbLogDim() {return bLogDim; }
    public ScrollView getVwLog() {return vwLog; }
    public TextView getinfoLog() {return infoLog; }


    @Override
    protected void onResume() {
        super.onResume();


    }

    @Override
    protected void onPause() {
        super.onPause();

    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        AscoltatoreMainActivity Ascoltatore = new AscoltatoreMainActivity(this);


        /* SERVER */
        tvServer = (TextView) findViewById(R.id.tvServer);
        tvStatus = (TextView) findViewById(R.id.tvStatus);
        bServer=findViewById(R.id.bServer);
        bServer.setOnClickListener(Ascoltatore);
        bServer.setTag("");
        bServer.callOnClick();



        infoLog = (TextView) findViewById(R.id.infoip);

        tvSensori= new TextView[3];
        tvSensori[0] = (TextView) findViewById(R.id.tvTYPE_MAGNETIC_FIELD_OUT);
        tvSensori[1] = (TextView) findViewById(R.id.tvTYPE_LIGHT_OUT);
        tvSensori[2] = (TextView) findViewById(R.id.tvTYPE_PROXIMITY_OUT);

        /* SENSOR */
        vwSensor=findViewById(R.id.vwSensor);
        bSensorDim=findViewById(R.id.bSensorDim);
        bSensorDim.setOnClickListener(Ascoltatore);
        bSensorDim.setTag(TAG_Visible);
        bSensorDim.callOnClick();

        /* SET */
        vwSet=findViewById(R.id.vwSet);
        etDeviceName = (EditText) findViewById(R.id.etDeviceName);
        etTimeUpdate = (EditText) findViewById(R.id.etTimeUpdate);
        bSetDim=findViewById(R.id.bSetDim);
        bSetDim.setOnClickListener(Ascoltatore);
        bSetDim.setTag(TAG_Visible);
        bSetDim.callOnClick();

        /* LOG */
        vwLog=findViewById(R.id.vwLog);
        bLogDim=findViewById(R.id.bLogDim);
        bLogDim.setOnClickListener(Ascoltatore);
        bLogDim.setTag(TAG_Visible);
        bLogDim.callOnClick();


    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }


}