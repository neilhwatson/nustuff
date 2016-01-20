## Workflow with Chef SDK

Very early Chef learning.

1. Create a new cookbook with chef generate cookbook <name>
1. Write serverspec integration tests in integraion directory.
1. Write chefspec unit test in 'unit/recipes/'. Test with 'chef exec rpec --color spec/unit/recipes/default_spec.rb'
1. Test cookbook with 'foodcritic recipe.rb'.
1. Run the cookbook with 'kitchen converge'.
1. Test the results with 'kitchen verify'
