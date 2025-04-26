#!/bin/bash

retention="6 months"

synapse-admin delete media --local $(date +%m/%d/%Y -d "$retention ago")
synapse-admin delete media --remote $(date +%m/%d/%Y -d "$retention ago")
