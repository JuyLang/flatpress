<table class="entrylist">
<thead><tr>
{if !$delete}<th></th>{/if}
<th>{$plang.app_date}</th>
<th>{$plang.app_content}</th>
<th>{$plang.app_author}</th>
<th>{$plang.app_email}</th>
<th>{$plang.app_ip}</th>
{if !$delete}<th>{$plang.app_actions}</th>{/if}
</tr></thead>
<tbody>
{assign var="i" value=0}
{foreach from=$entries key=entryid item=entry}
{if count($entry.$fetch)>0 && !$is_managing}<tr><td colspan="{if $delete}5{else}7{/if}">{$entryid|idToSubject} ({$entryid})</td></tr>
{/if}
{foreach from=$entry.$fetch item=comm key=comm_id}
{assign var="i" value=$i+1}
<tr>
{if !$delete}<td class="td_select_{$fetch}"><input type="checkbox" name="select[e{$entryid}_c{$comm_id}]" /></td>{/if}
<td>{$comm.date|date_format:"%D, %T"}</td>
<td class="main_cell">
{$comm.content|strip_tags}
{if $delete}<input type="hidden" value="on" name="select[e{$entryid}_c{$comm_id}]" />

{/if}
</td>
<td>{if $comm.url}<a href="{$comm.url|wp_specialchars}">{$comm.name|wp_specialchars}</a>{else}{$comm.name|wp_specialchars}{/if}</td>
<td><a href="mailto:{$comm.email|wp_specialchars}">{$comm.email|wp_specialchars}</a></td>
<td>{$comm.ip-address}</td>
{if !$delete}<td>
{if $is_managing && $use_akismet}
<a href="{$action_url|cmd_link:commspam:"e`$entryid`_c`$comm_id`"}" title="{$plang.man_spam}"><img src="{$plugin_url}imgs/spam.png" alt="{$plang.man_spam}" /></a>
{elseif !$is_managing}
<a href="{$action_url|cmd_link:publishcomm:"e`$entryid`_c`$comm.id`"}" title="{$plang.app_publish}"><img src="{$plugin_url}imgs/publish.png" alt="{$plang.app_publish}" /></a>
{if $fetch=='akismet'}
<a href="{$action_url|cmd_link:pubnoham:"e`$entryid`_c`$comm.id`"}" title="{$plang.app_pubnotham}"><img src="{$plugin_url}imgs/publish.png" alt="{$plang.app_pubnotham}" /></a>
{/if}
{/if}
{if $is_managing}
{assign var="rm_url" value=$action_url|cmd_link:deletecomm2:"e`$entryid`_c`$comm_id`"}
{else}
{assign var="rm_url" value=$action_url|cmd_link:deletecomm:"e`$entryid`_c`$comm_id`"}
{/if}
<a href="{$rm_url}" title="{$plang.app_delete}"><img src="{$plugin_url}imgs/delete.png" alt="{$plang.app_delete}" /></a>
</td>
{/if}
</tr>
{/foreach}
{/foreach}
{if $i==0}
<tr><td colspan="{if $delete}5{else}7{/if}">{$plang.app_nocomms}</td></tr>{/if}
</tbody>
</table>
{if !$delete}
<div class="commentcenter_select" style="display: none;">
	<a href="#" rel="selectAll[td_select_{$fetch}]">{$plang.select_all}</a> 
	<a href="#" rel="deselectAll[td_select_{$fetch}]">{$plang.deselect_all}</a>
</div>
{/if}
