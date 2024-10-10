maxSubArray:
 
    mv s0, a0               # s0 = nums
    mv s1, a1               # s1 = numsSize
    lw s2, 0(s0)            # s2 = max_current = nums[0]
    lw s3, 0(s0)            # s3 = max_global = nums[0]


    li s4, 1                # s4 = i = 1
loop:
    bge s4, s1, end_loop    # if (i >= numsSize) break
    slli t0, s4, 2          # t0 = i * 4 (因為每個整數佔 4 字節)
    add t1, s0, t0          # t1 = nums + i*4
    lw t2, 0(t1)            # t2 = nums[i]

    add t3, s2, t2          # t3 = max_current + nums[i]
    blt t2, t3, no_change   # if (nums[i] > (max_current + nums[i]))
    mv s2, t2               # max_current = nums[i]
    j check_global
    
no_change:
    mv s2, t3               # max_current = max_current + nums[i]
    
check_global:
    blt s2, s3, no_global   # if (max_current > max_global)
    mv s3, s2               # max_global = max_current
    
no_global:
    addi s4, s4, 1          # i++
    j loop
    
end_loop:
    mv a0, s3               # return max_global
    ret