package khoa.demo.day08_list;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class SingleListActivity extends ListActivity {
    private String[] listSubject = {"PRJ311", "PRJ321", "PRM391", "PRX301", "Capstone"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_single_list);
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this,android.R.layout.simple_list_item_1, listSubject);
        setListAdapter(adapter);
    }

    @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
        Intent intent = new Intent(this, DetailActivity.class);
        intent.putExtra("subject", listSubject[position]);
        startActivity(intent);
    }
}
