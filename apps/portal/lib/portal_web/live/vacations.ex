defmodule PortalWeb.Live.Vacations do
  use Phoenix.Component

  def vacations(assigns) do
    ~H"""
    <div class="w-full  bg-base-100 p-4 rounded-lg">
      <div class="flex items-center justify-between">
        <div class="flex  justify-normal gap-2 sm:gap-4">
          <p class="font-semibold text-xl w-48">September 2025<span class="text-xs ml-2 ">Beta</span></p>
          <button class="btn  btn-square btn-sm btn-ghost">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true" class="w-5 h-5">
              <path fill-rule="evenodd" d="M7.72 12.53a.75.75 0 010-1.06l7.5-7.5a.75.75 0 111.06 1.06L9.31 12l6.97 6.97a.75.75 0 11-1.06 1.06l-7.5-7.5z" clip-rule="evenodd"></path>
            </svg>
          </button>
          <button class="btn  btn-sm btn-ghost normal-case">Månad</button>
          <button class="btn btn-square btn-sm btn-ghost">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true" class="w-5 h-5">
              <path fill-rule="evenodd" d="M16.28 11.47a.75.75 0 010 1.06l-7.5 7.5a.75.75 0 01-1.06-1.06L14.69 12 7.72 5.03a.75.75 0 011.06-1.06l7.5 7.5z" clip-rule="evenodd"></path>
            </svg>
          </button>
        </div>
        <div><button class="btn  btn-sm btn-ghost btn-outline normal-case">Ny event</button></div>
      </div>
      <div class="my-4 divider"></div>
      <div class="grid grid-cols-7 gap-6 sm:gap-12 place-items-center">
        <div class="text-xs capitalize">Mån</div>
        <div class="text-xs capitalize">Tis</div>
        <div class="text-xs capitalize">Ons</div>
        <div class="text-xs capitalize">Tor</div>
        <div class="text-xs capitalize">Fre</div>
        <div class="text-xs capitalize">Lör</div>
        <div class="text-xs capitalize">Sön</div>
      </div>
      <div class="grid grid-cols-7 mt-1  place-items-center">
        <div class=" border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false  text-slate-400 dark:text-slate-600"> 29</p>
        </div>
        <div class="col-start-2 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false  text-slate-400 dark:text-slate-600"> 30</p>
        </div>
        <div class="col-start-3 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300  bg-blue-100 dark:bg-blue-400 dark:hover:bg-base-300 dark:text-white false">1</p>
        </div>
        <div class="col-start-4 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 2</p>
        </div>
        <div class="col-start-5 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 3</p>
        </div>
        <div class="col-start-6 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 4</p>
        </div>
        <div class="col-start-7 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 5</p>
        </div>
        <div class=" border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 6</p>
        </div>
        <div class="col-start-2 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 7</p>
        </div>
        <div class="col-start-3 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 8</p>
        </div>
        <div class="col-start-4 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 9</p>
        </div>
        <div class="col-start-5 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 10</p>
          <p class="text-xs px-2 mt-1 truncate  bg-orange-200 dark:bg-orange-600 dark:text-orange-100">Ledigt</p>
        </div>
        <div class="col-start-6 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 11</p>
        </div>
        <div class="col-start-7 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 12</p>
        </div>
        <div class=" border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 13</p>
        </div>
        <div class="col-start-2 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 14</p>
        </div>
        <div class="col-start-3 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 15</p>
        </div>
        <div class="col-start-4 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 16</p>
        </div>
        <div class="col-start-5 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 17</p>
          <p class="text-xs px-2 mt-1 truncate  bg-orange-200 dark:bg-orange-600 dark:text-orange-100">Ledigt</p>
        </div>
        <div class="col-start-6 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 18</p>
        </div>
        <div class="col-start-7 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 19</p>
        </div>
        <div class=" border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 20</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-2 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 21</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-3 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 22</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-4 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 23</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-5 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 24</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-6 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 25</p>
        </div>
        <div class="col-start-7 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 26</p>
        </div>
        <div class=" border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 27</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-2 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 28</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-3 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 29</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-4 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 30</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-5 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false false"> 31</p>
          <p class="text-xs px-2 mt-1 truncate  bg-purple-200 dark:bg-purple-600 dark:text-purple-100">Semester</p>
        </div>
        <div class="col-start-6 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false  text-slate-400 dark:text-slate-600"> 1</p>
        </div>
        <div class="col-start-7 border border-solid w-full h-28  ">
          <p class="inline-block flex items-center  justify-center h-8 w-8 rounded-full mx-1 mt-1 text-sm cursor-pointer hover:bg-base-300 false  text-slate-400 dark:text-slate-600"> 2</p>
        </div>
      </div>
    </div>
    """
  end
end
