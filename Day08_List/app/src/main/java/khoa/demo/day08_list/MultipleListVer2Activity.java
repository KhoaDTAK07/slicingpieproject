package khoa.demo.day08_list;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

public class MultipleListVer2Activity extends AppCompatActivity {
    private String[] listSubject;
    private List<String> listChoose;
    private ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_multiple_list_ver2);
        listView = findViewById(R.id.listSubject);
        listView.setChoiceMode(ListView.CHOICE_MODE_MULTIPLE);
        listSubject = getResources().getStringArray(R.array.lists);
        listView.setTextFilterEnabled(true);
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_multiple_choice, listSubject);
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                listChoose = new ArrayList<>();
                for (int i = 0; i < parent.getCount(); i++) {
                    boolean check = listView.getCheckedItemPositions().get(i);
                    if(check){
                        String name = parent.getAdapter().getItem(i).toString();
                        Toast.makeText(MultipleListVer2Activity.this,"Selected: " + name, Toast.LENGTH_LONG).show();
                        listChoose.add(name);
                    }
                }
            }
        });
    }

    public void clickToSave(View view) {
        Intent intent = new Intent(this,DetailActivity.class);
        String result = "";
        for (int i = 0; i < listChoose.size(); i++) {
            result += listChoose.get(i) + "-";
        }
        intent.putExtra("subject", result);
        startActivity(intent);
    }
}
