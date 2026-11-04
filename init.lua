local definition = table.copy(core.registered_nodes["default:snow"])

definition.waving = 2
definition.drop = definition.drop or "default:snow"
definition.groups.not_in_creative_inventory = 1
definition.on_construct = function (pos)
    local nodeunder = core.get_node( vector.subtract(pos, vector.new(0, 1, 0)) )

    if nodeunder == nil or (core.registered_nodes[nodeunder.name].waving == nil or core.registered_nodes[nodeunder.name].waving <= 0) then
        core.swap_node(pos, {name = "default:snow"})
    end
end

core.register_node("wavingsnow:waving_snow", definition)


core.override_item("default:snow", {on_construct = function (pos)
    local nodeunder = core.get_node( vector.subtract(pos, vector.new(0, 1, 0)) )

    if nodeunder and core.registered_nodes[nodeunder.name].waving and core.registered_nodes[nodeunder.name].waving > 0 then
        core.swap_node(pos, {name = "wavingsnow:waving_snow"})
    end
end})

core.register_lbm({
    label = "Generate waving snow on leaves",
    name = "wavingsnow:generate_waving_snow",
    nodenames = {"default:snow"},
    run_at_every_load = false,
    action = function (pos, node, dtime_s)
        local nodeunder = core.get_node( vector.subtract(pos, vector.new(0, 1, 0)) )

        if nodeunder and core.registered_nodes[nodeunder.name].waving and core.registered_nodes[nodeunder.name].waving > 0 then
            core.swap_node(pos, {name = "wavingsnow:waving_snow"})
        end
    end
})
