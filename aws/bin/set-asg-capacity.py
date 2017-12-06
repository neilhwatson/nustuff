#!/usr/bin/env python

"""
Set the desired capacity of an autoscaling group. Reads capacity and ASG name
from environment. As a safety, capacity cannot be more than 9.

EXAMPLES

Set ASG 'prod' to 3. Region is optional if your .aws/config is present.

ASG=prod CAP=3 AWS_DEFAULT_REGION=us-east-2 set-asg-capacity.py

AUTHOR

Neil H. Watson, http://watson-wilson.ca, neil@watson-wilson.ca

LICENSE and COPYRIGHT

The MIT License (MIT)

Copyright (c) 2017 Neil H Watson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

import boto3
import re
import os

def validate_env(ASG, CAP):
    """Validate env arguments."""

    if not re.search('(?ix) \A \w+ \Z', ASG):
        raise TypeError('Invalid ASG name:['+ASG+']')

    if not re.search('(?x) \A \d{1} \Z', CAP):
        raise TypeError('Invalid CAP number:['+CAP+']')

    return

def lambda_handler(event, context):

    ASG=os.environ['ASG']
    CAP=os.environ['CAP']
    REGION=os.environ['REGION']

    validate_env(ASG=ASG, CAP=CAP)

    CAP=int(CAP)

    asg = boto3.client('autoscaling', region_name=REGION)

    response = asg.set_desired_capacity(
        AutoScalingGroupName=ASG,
        DesiredCapacity=int(CAP),
        HonorCooldown=False
    )

    print response
