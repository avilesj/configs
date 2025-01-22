# Laptops

TLP is used as an attempt to manage power

## AMD
If you have a AMD CPU/APU, you might have to tinker with scaling governors to either get extra battery or fix some issues.

- HP Elitebook 845 G10
  - CPU: Ryzen 7540U
  - Problem: keystrokes might repeat themselves under some energy settings
  - Solution: Use scaling governor 'performance'
  - Additional tweaks: Use 'amd_pstate=passive' kernel parameter
