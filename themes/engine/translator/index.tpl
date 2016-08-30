<p>Буде перекладено наступні таблиці:</p>
<form action="module/run/translator/process/{$id}" method="post" id="translate">
{foreach $tables as $k=>$table}
   <div id="t-{$table}" class="table-to-translate">
       <h3 style="text-align: left;">{$table}</h3>
       <div class="progress" id="progress-{$table}">
           <div class="progress-bar" style="width:0%"></div>
       </div>
       <input type="hidden" name="table[]" value="{$table}">
   </div>
{/foreach}
    <input type="hidden" name="token" value="{$token}">
</form>