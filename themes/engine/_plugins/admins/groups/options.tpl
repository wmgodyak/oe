{foreach $items as $item}
    <option {if $disabled}disabled{/if} {if $data.parent_id == $item.id}selected{/if} value="{$item.id}">{for $i=0;$i<$level;$i++}. {/for} {$item.name}</option>
    {if $item.isfolder}
        {include file="plugins/admins/groups/options.tpl" items=$item.items level = $level+1}
    {/if}
{/foreach}