# Github Actions cheatsheet

## Human approval gate

Sadly approvals work by configuration a Github Environment you can't approve steps, or even a specific job unless you make an environment solely for approvals.

```yaml
name: approval
on:
  workflow_dispatch:

jobs:

  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: do stuff
        run: |
          echo doing stuff!

  deploy_successful:
    runs-on: ubuntu-latest
    needs: [ deploy ]
    environment: needs-approval
    steps:
      - name: do stuff
        run: |
          echo doing stuff!

  rollback: # Only runs is previous job is rejected
    runs-on: ubuntu-latest
    needs: [ deploy_successful ]
    if: always() && needs.deploy_successful.result == 'failure'
    steps:
      - name: rollback
        run: |
          echo rolling back
```

## Rollbacks

```yaml
name: Show how deploy and rollback can work

on:
  push:

  workflow_dispatch:
    inputs:
      deploy_fail:
        type: boolean
        description: Similate a failed deploy with rollback. If unchecked, deploy will work.
        default: false
      rollback_prod:
        type: boolean
        description: Rollback production by deploying in-prod git tag
        default: false

jobs:

  set-env:
    runs-on: ubuntu-latest
    steps:
    - name: Set rollback whether on push or dispatch
      id: rollback_prod
      env:
        EVENT: ${{ github.event_name }}
        ROLLBACK_PROD: ${{ github.event.inputs.rollback_prod }}
      run: |
        if [[ "$ROLLBACK_PROD" == 'true' ]]
        then
          echo "::set-output name=rollback_prod::true"
        else
          echo "::set-output name=rollback_prod::false"
        fi
    outputs:
      rollback_prod: ${{ steps.rollback_prod.outputs.rollback_prod }}

  deploy:
    runs-on: ubuntu-latest
    needs: set-env

    steps:

    - name: Checkout repo prod tag to roll back
      if: github.event.inputs.rollback_prod == 'true'
      uses: actions/checkout@ec3a7ce113134d7a93b817d10a8272cb61118579 # v2.4.0
      with:
        ref: in-prod

    - name: Checkout repo
      if: github.event.inputs.rollback_prod != 'true'
      uses: actions/checkout@ec3a7ce113134d7a93b817d10a8272cb61118579 # v2.4.0

    - name: deploy
      run: |
        echo rollback_prod = ${{ needs.set-env.outputs.rollback_prod }}
        git status
        echo deploying stuff here

    - name: cause failure
      if: github.event.inputs.deploy_fail == 'true'
      run: |
        false

    - name: tag successful deploy
      if: github.ref_name == 'main' && github.event.inputs.rollback_prod != 'true'
      run: |
        # github.event.publisher.name
        # github.event.publisher.email
        git config --global user.name "cicd"
        git config --global user.email "cicd@example.com"
        git tag in-prod -a -m "This is running in production"
        git push --force origin prod
```



    environment: testing
    env:
      dothis: true
      tflint_ver: v0.35.0

## Shell globbing

```yaml
    steps:
    - name: Tricky shell globbing
      run: |
        bash --version
        touch foo.yaml
        touch bar.yml
        shopt -s extglob
        ls -l *.y?(a)ml
```

## Retry a failed stop

No native retries like Jenkins.  Copy and paste dog!

```yaml
    - name: Step that might fail
      id: mystep
      continue-on-error: true
      run: |
        false
    - name: Retry previous step if it fails
      if: steps.mystep.outcome=='failure'
      run: |
        true
```
## Compound expressions

```yaml
    - name: compound expression
      if: 1==1 && 1>0
      run: |
        true
    - name: another compound expression
      if: 1==1 && ${{ env.dothis == true }}
      run: |
        true
```

## Post cleanup

No post sections for jobs or entire workflows like Jenkins. Why copy a mature produce when you can half ass it?

```yaml
  cleaup:
    runs-on: ubuntu-latest
    needs: [ deploy ]
    if: always()
    steps:
    - name: cleanup
      run: |
        true

  on-failure-and-reusable:
    needs: [ failure ]
    if: failure()
    uses: ./.github/workflows/reusable.yaml
```

## Reusable workflow

### The workflow

```yaml
name: terraform apply
on:
  workflow_call:
    inputs:
      ROOT_MODULE:
        required: true
        type: string
      environment: # Github Environment
        required: true
        type: string
      apply:
        type: boolean
        default: false
    outputs:
      tf_output:
        value: ${{ jobs.deploy.outputs.tf_output }}

jobs:

  deploy:
    runs-on: ubuntu-latest
    environment: ${{ inputs.environment }}
    outputs:
      tf_output: ${{ steps.tf_output.outputs.tf_output }}
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      AWS_REGION: ${{ inputs.AWS_REGION }}
    steps:
      - name: Checkout repo
        if: inputs.rollback_prod != 'true'
        uses: actions/checkout@ec3a7ce113134d7a93b817d10a8272cb61118579 # v2.4.0
      - name: Terraform Init
        run: terraform -chdir=${{ inputs.ROOT_MODULE }} init
      - name: Terraform validate
        run: terraform -chdir=${{ inputs.ROOT_MODULE }} validate
      - name: Terraform plan
        run: terraform -chdir=${{ inputs.ROOT_MODULE }} plan ${{ inputs.args }} -var-file=${TF_VAR_FILE}
      - name: Terraform apply one
        if: inputs.apply == true
        id: apply1
        continue-on-error: true
        run: terraform -chdir=${{ inputs.ROOT_MODULE }} apply -auto-approve ${{ inputs.args }} -var-file=${TF_VAR_FILE}
      - name: Terraform retry apply
        if: steps.apply1.outcome == 'failure' && inputs.apply == true
        id: apply2
        run: terraform -chdir=${{ inputs.ROOT_MODULE }} apply -auto-approve ${{ inputs.args }} -var-file=${TF_VAR_FILE}

      - name: Terraform outputs
        if: inputs.apply == true
        id: tf_output
        run: |
          output=$(terraform -chdir=${{ inputs.ROOT_MODULE }} output -json )
          # the following lines are only required for multi line json
          output="${output//'%'/'%25'}"
          output="${output//$'\n'/'%0A'}"
          output="${output//$'\r'/'%0D'}"
          echo "::set-output name=tf_output::$output"
```

### Call the workflow

```yaml
  tf-plan:
    uses: ./.github/workflows/reusable.yaml
    secrets: inherit # Inherts all workflow Environment secrets
    with:
      ROOT_MODULE: terraform/vpc
      apply: false
      environment: testing

  tf-apply:
    uses: ./.github/workflows/reusable.yaml
    secrets: inherit # Inherts all workflow Environment secrets
    with:
      ROOT_MODULE: terraform-code/vpc
      apply: true
      environment: testing
```

