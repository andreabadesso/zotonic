%% @author Marc Worrell <marc@worrell.nl>
%% @copyright 2010 Marc Worrell
%% @doc Move an element to another place, appending it to the target.

%% Copyright 2010 Marc Worrell
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(action_base_move).
-include("zotonic.hrl").
-export([render_action/4]).

render_action(_TriggerId, TargetId, Args, Context) ->
    EltSel = case proplists:get_value(element_sel, Args) of
                undefined -> [$#, proplists:get_value(element, Args, "none") ];
                Sel -> z_render:css_selector(Sel)
             end,
    CssSelector = z_render:css_selector(proplists:get_value(id, Args, TargetId), Args),
    {[<<"$(">>, z_render:quote_css_selector(EltSel),
      <<").append($(">>, z_render:quote_css_selector(CssSelector), $), $), $;], Context}.
