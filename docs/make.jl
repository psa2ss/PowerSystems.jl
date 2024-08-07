using Documenter, PowerSystems
import DataStructures: OrderedDict
using Literate

# This is commented out because the output is not user-friendly. Deliberation on how to best
# communicate this information to users is ongoing.
#include(joinpath(@__DIR__, "src", "generate_validation_table.jl"))
include(joinpath(@__DIR__, "make_model_library.jl"))

pages = OrderedDict(
        "Welcome Page" => "index.md",
        "Quick Start Guide" => "quick_start_guide.md",
        "Tutorials" =>  Any[
            "Introduction" => "tutorials/basics.md",
            "Parsing PowerFlow Data" => "tutorials/parse_powerflow_cases.md",
            "Parsing Tabular Data" => "tutorials/parse_tabular_data.md",
            "Add Forecasts" => "tutorials/add_forecasts.md",
            "Serialize Data" => "tutorials/serialize_data.md",
            "Use Dynamic Data" => "tutorials/dynamic_data.md",
            "PowerSystemCaseBuilder" => "tutorials/powersystembuilder.md",
            "Add an Operating Cost" => "tutorials/add_cost_curve.md",
        ],
        "Modeler Guide" =>
            Any[
            "modeler_guide/type_structure.md",
            "modeler_guide/system.md",
            "modeler_guide/time_series.md",
            "modeler_guide/enumerated_types.md",
            "modeler_guide/example_dynamic_data.md",
            "modeler_guide/system_dynamic_data.md",
            "modeler_guide/cost_functions.md",
            "modeler_guide/market_bid_cost.md",
            "modeler_guide/modeling_with_JuMP.md",
            "modeler_guide/parsing.md",
            "modeler_guide/glossary.md",
            ],
        "Model Developer Guide" =>
            Any["Extending Parsing" => "model_developer_guide/extending_parsing.md",
                "Adding Types" => "model_developer_guide/adding_custom_types.md",
                "Adding Additional Fields" => "model_developer_guide/adding_additional_fields.md",

            ],
            "Code Base Developer Guide" =>
            Any["Developer Guide" => "code_base_developer_guide/developer.md",
            "Adding New Types" => "code_base_developer_guide/adding_new_types.md",
            "Troubleshooting" => "code_base_developer_guide/troubleshooting.md"
            ],
        "Model Library" => Any[],
        "Public API Reference" => "api/public.md",
        "Internal API Reference" => "api/internal.md"
)

pages["Model Library"] = make_model_library(
     categories = [
        Topology,
        StaticInjection,
        Service,
        Branch
    ],
    exceptions = [PSY.DynamicComponent,
                  PSY.ActivePowerControl,
                  PSY.ReactivePowerControl,
                  PSY.DynamicBranch,
                  PSY.HybridSystem,
                  PSY.OperationalCost
                  ],
    manual_additions =
        Dict("Service" => ["Reserves" => "model_library/reserves.md"],
        "StaticInjection" => ["HybridSystem" => "model_library/hybrid_system.md"],
        "DynamicInjection" => ["Dynamic Inverter" => "model_library/dynamic_inverter.md",
        "Dynamic Generator" => "model_library/dynamic_generator.md",
        ],
        "Branch" => ["Dynamic Lines" => "model_library/dynamic_branch.md"],
        "Operating Costs" => ["ThermalGenerationCost" =>"model_library/thermal_generation_cost.md",
        "HydroGenerationCost" =>"model_library/hydro_generation_cost.md",
        "RenewableGenerationCost" =>"model_library/renewable_generation_cost.md",
        "StorageCost" =>"model_library/storage_cost.md",
        "LoadCost" =>"model_library/load_cost.md",
        "MarketBidCost" =>"model_library/market_bid_cost.md"],
        "Cost Curves" => ["Variable Cost Curves" => "model_library/cost_curves.md",
        "Value Curves" => "model_library/value_curves.md"]
        )
)

# postprocess function to insert md
function insert_md(content)
    m = match(r"APPEND_MARKDOWN\(\"(.*)\"\)", content)
    if !isnothing(m)
        md_content = read(m.captures[1], String)
        content = replace(content, r"APPEND_MARKDOWN\(\"(.*)\"\)" => md_content)
    end
    return content
end

# This code performs the automated addition of Literate - Generated Markdowns. The desired
# section name should be the name of the file for instance network_matrices.jl -> Network Matrices
julia_file_filter = x -> occursin(".jl", x)
folders = Dict(
    "Model Library" => filter(julia_file_filter, readdir("docs/src/model_library")),
    "Modeler Guide" => filter(julia_file_filter, readdir("docs/src/modeler_guide")),
    "Model Developer Guide" => filter(julia_file_filter, readdir("docs/src/model_developer_guide")),
    "Code Base Developer Guide" => filter(julia_file_filter, readdir("docs/src/code_base_developer_guide")),
)
for (section, folder) in folders
    for file in folder
        @show file
        section_folder_name = lowercase(replace(section, " " => "_"))
        outputdir = joinpath(pwd(), "docs", "src", "$section_folder_name")
        inputfile = joinpath("$section_folder_name", "$file")
        infile_path = joinpath(pwd(), "docs", "src", inputfile)
        outputfile = string("generated_", replace("$file", ".jl" => ""))
        execute = occursin("EXECUTE = TRUE", uppercase(readline(infile_path))) ? true : false
        execute && include(infile_path)
        Literate.markdown(infile_path,
                          outputdir;
                          name = outputfile,
                          credit = false,
                          flavor = Literate.DocumenterFlavor(),
                          documenter = true,
                          postprocess = insert_md,
                          execute = execute)
        subsection = titlecase(replace(split(file, ".")[1], "_" => " "))
        push!(pages[section], ("$subsection" =>  joinpath("$section_folder_name", "$(outputfile).md")))
    end
end

makedocs(
    modules = [PowerSystems, InfrastructureSystems],
    format = Documenter.HTML(prettyurls = haskey(ENV, "GITHUB_ACTIONS"),),
    sitename = "PowerSystems.jl",
    authors = "Jose Daniel Lara, Daniel Thom, Kate Doubleday, and Clayton Barrows",
    pages = Any[p for p in pages]
)

deploydocs(
    repo = "github.com/NREL-Sienna/PowerSystems.jl.git",
    target = "build",
    branch = "gh-pages",
    devbranch = "main",
    devurl = "dev",
    push_preview=true,
    versions = ["stable" => "v^", "v#.#"],
)
