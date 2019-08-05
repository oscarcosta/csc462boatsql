#!/bin/bash

## Configure nodes labels
docker node update --label-add type=services ip-172-31-30-87
docker node update --label-add type=data ip-172-31-31-54
docker node update --label-add type=data ip-172-31-22-142
