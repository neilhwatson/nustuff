## Workflow with Chef SDK

Very early Chef learning.

1. Write serverspec integration tests in integraion directory. Test with 'kitchen test'.
1. Write chefspec unit test in 'unit/recipes/'. Test with 'chef exec rpec --color spec/unit/recipes/default_spec.rb'
1. Test cookbook with 'foodcritic recipe.rb'.
