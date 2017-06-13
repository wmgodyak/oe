 {if $variants|count}
     <table class="table">
         <tr>
             <th style="width: 50px;">Photo</th>
             <th>Variant</th>
             <th>Availability</th>
             {foreach $customers_group as $group}
                 <th> {$group.name}</th>
             {/foreach}
             <th style="width: 60px;">Del.</th>
         </tr>
            {foreach $variants as $variant}
                <tr id="variant-{$variant.id}">
                    <td>
                        <a class="variant-picture variant-{$variant.id}" data-id="{$variant.id}">
                            {if empty($variant.img)}
                                <i class="fa fa-picture-o"></i>
                            {else}
                                <img style="max-width: 50px;" src="{$variant.img}" alt="variant img">
                            {/if}
                        </a>
                    </td>
                    <td>
                        {assign var="total" value=count($variant.features) - 1}
                        {foreach $variant.features as $i=>$feature}
                            {$feature.values_name} {if $i<$total}*{/if}
                        {/foreach}
                    </td>
                    <td>
                        <select name="variants[{$variant.id}][in_stock]" class="form-control">
                            <option {if $variant.in_stock == 1}selected{/if} value="1">In stock</option>
                            <option {if $variant.in_stock == 2}selected{/if}  value="2">For order</option>
                            <option {if $variant.in_stock == 0}selected{/if}  value="0">none</option>
                        </select>
                    </td>
                    {foreach $variant.prices as $i=>$group}
                        <td><input name="variants[{$variant.id}][prices][{$group.id}]" type="text" required class="form-control" value="{$group.price}"></td>
                    {/foreach}
                    <td>
                        <button type="button" class="btn btn-danger b-products-rm-variant " title="Видалити" data-id="{$variant.id}"><i class="fa fa-remove"></i></button>
                    </td>
                </tr>
            {/foreach}
     </table>
        {else}
     <p style="text-align: center">empty</p>
    {/if}