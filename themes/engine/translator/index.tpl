<p>Буде перекладено наступні таблиці:</p>

{foreach $tables as $k=>$table}
    <h3 style="text-align: left;">{$table}</h3>
    <div class="progress">
        <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
            <span class="sr-only">0% Complete</span>
        </div>
    </div>
{/foreach}
