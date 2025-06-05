defmodule AkuWeb.Main do
  use AkuWeb, :live_view
  alias Aku.Count
  alias Phoenix.PubSub
  alias Aku.Presence

  @topic Count.topic
  @presence_topic "presence"

  def mount(_params, _session, socket) do
    initial_present =
      if connected?(socket) do
        PubSub.subscribe(Aku.PubSub, @topic)
        Presence.track(self(), @presence_topic, socket.id, %{})
        AkuWeb.Endpoint.subscribe(@presence_topic)
        Presence.list(@presence_topic)
        |> map_size
      else
        0
      end
    {:ok, assign(socket, val: Count.current(), present: initial_present)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :val, Count.incr())}
  end

  def handle_event("dec", _, socket) do
    {:noreply, assign(socket, :val, Count.decr())}
  end

  def handle_info({:count, count}, socket) do
    {:noreply, assign(socket, val: count)}
  end

  def handle_info(
    %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
    %{assigns: %{present: present}} = socket) do
    {_, joins} = Map.pop(joins, socket.id, %{})
    new_present = present + map_size(joins) - map_size(leaves)
    {:noreply, assign(socket, :present, new_present)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="navbar sticky bg-base-100 z-2 shadow-md">
        <div class="flex-1">
          <label
            for="left-sidebar-drawer"
            class="btn btn-primary drawer-button lg:hidden">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              aria-hidden="true"
              class="h-5 inline-block w-5">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5">
              </path>
            </svg>
          </label>
          <h1 class="text-2xl font-semibold ml-2">Dashboard</h1>
        </div>
      </div>

      <main class="flex-1 overflow-y-auto md:pt-4 pt-4 px-6  bg-base-200">
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div class="">
            <div class="w-72 ">
              <input type="text" class="input input-bordered w-72" placeholder="YYYY-MM-DD ~ YYYY-MM-DD" autocomplete="off" role="presentation" value="2025-06-04 ~ 2025-06-04"/>
              <button type="button" class="invisible">
                <svg class="h-5 w-5"
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
              </button>
              <div class="transition-all ease-out duration-300 absolute z-10 mt-[1px] text-sm lg:text-xs 2xl:text-sm translate-y-4 opacity-0 hidden">
                <div class="absolute z-20 h-4 w-4 rotate-45 mt-0.5 ml-[1.2rem] border-l border-t border-gray-300 bg-white dark:bg-slate-800 dark:border-slate-600"></div>
                <div class="mt-2.5 shadow-sm border border-gray-300 px-1 py-0.5 bg-white dark:bg-slate-800 dark:text-white dark:border-slate-600 rounded-lg">
                  <div class="flex flex-col lg:flex-row py-2">
                    <div class="md:border-b mb-3 lg:mb-0 lg:border-r lg:border-b-0 border-gray-300 dark:border-gray-700 pr-1">
                      <ul class="w-full tracking-wide flex flex-wrap lg:flex-col pb-1 lg:pb-0">
                        <li class="whitespace-nowrap w-1/2 md:w-1/3 lg:w-auto transition-all duration-300 hover:bg-gray-100 dark:hover:bg-white/10 p-2 rounded cursor-pointer text-blue-600 dark:text-blue-400 dark:hover:text-blue-400 hover:text-blue-700">Today</li>
                        <li class="whitespace-nowrap w-1/2 md:w-1/3 lg:w-auto transition-all duration-300 hover:bg-gray-100 dark:hover:bg-white/10 p-2 rounded cursor-pointer text-blue-600 dark:text-blue-400 dark:hover:text-blue-400 hover:text-blue-700">Yesterday</li>
                        <li class="whitespace-nowrap w-1/2 md:w-1/3 lg:w-auto transition-all duration-300 hover:bg-gray-100 dark:hover:bg-white/10 p-2 rounded cursor-pointer text-blue-600 dark:text-blue-400 dark:hover:text-blue-400 hover:text-blue-700">Last 7 days</li>
                        <li class="whitespace-nowrap w-1/2 md:w-1/3 lg:w-auto transition-all duration-300 hover:bg-gray-100 dark:hover:bg-white/10 p-2 rounded cursor-pointer text-blue-600 dark:text-blue-400 dark:hover:text-blue-400 hover:text-blue-700">Last 30 days</li>
                        <li class="whitespace-nowrap w-1/2 md:w-1/3 lg:w-auto transition-all duration-300 hover:bg-gray-100 dark:hover:bg-white/10 p-2 rounded cursor-pointer text-blue-600 dark:text-blue-400 dark:hover:text-blue-400 hover:text-blue-700">This month</li>
                        <li class="whitespace-nowrap w-1/2 md:w-1/3 lg:w-auto transition-all duration-300 hover:bg-gray-100 dark:hover:bg-white/10 p-2 rounded cursor-pointer text-blue-600 dark:text-blue-400 dark:hover:text-blue-400 hover:text-blue-700">Last month</li>
                      </ul>
                    </div>
                    <div class="flex items-stretch flex-col md:flex-row space-y-4 md:space-y-0 md:space-x-1.5 md:pl-2 pr-2 lg:pr-1">
                      <div class="w-full md:w-[297px] md:min-w-[297px]">
                        <div class="flex items-center space-x-1.5 border border-gray-300 dark:border-gray-700 rounded-md px-2 py-1.5">
                          <div class="flex-none">
                            <button type="button" class="dark:text-white/70 dark:hover:bg-white/10 dark:focus:bg-white/10 transition-all duration-300 hover:bg-gray-100 rounded-full p-[0.45rem] focus:ring-1 focus:ring-blue-500/50 focus:bg-blue-100/50">
                              <svg class="h-5 w-5"
                                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5"></path>
                              </svg>
                            </button>
                          </div>
                          <div class="flex flex-1 items-center space-x-1.5">
                            <div class="w-1/2">
                              <button type="button" class="w-full tracking-wide dark:text-white/70 dark:hover:bg-white/10 dark:focus:bg-white/10 transition-all duration-300 px-3 py-[0.55rem] uppercase hover:bg-gray-100 rounded-md focus:ring-1 focus:ring-blue-500/50 focus:bg-blue-100/50">Jun</button>
                            </div>
                            <div class="w-1/2">
                              <button type="button" class="w-full tracking-wide dark:text-white/70 dark:hover:bg-white/10 dark:focus:bg-white/10 transition-all duration-300 px-3 py-[0.55rem] uppercase hover:bg-gray-100 rounded-md focus:ring-1 focus:ring-blue-500/50 focus:bg-blue-100/50">2025</button>
                            </div>
                          </div>
                          <div class="flex-none">
                            <button type="button" class="dark:text-white/70 dark:hover:bg-white/10 dark:focus:bg-white/10 transition-all duration-300 hover:bg-gray-100 rounded-full p-[0.45rem] focus:ring-1 focus:ring-blue-500/50 focus:bg-blue-100/50">
                              <svg class="h-5 w-5"
                                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5"></path>
                              </svg>
                            </button>
                          </div>
                        </div>
                        <div class="px-0.5 sm:px-2 mt-0.5 min-h-[285px]">
                          <div class="grid grid-cols-7 border-b border-gray-300 dark:border-gray-700 py-2">
                            <div class="tracking-wide text-gray-500 text-center">Sun</div>
                            <div class="tracking-wide text-gray-500 text-center">Mon</div>
                            <div class="tracking-wide text-gray-500 text-center">Tue</div>
                            <div class="tracking-wide text-gray-500 text-center">Wed</div>
                            <div class="tracking-wide text-gray-500 text-center">Thu</div>
                            <div class="tracking-wide text-gray-500 text-center">Fri</div>
                            <div class="tracking-wide text-gray-500 text-center">Sat</div>
                          </div>
                          <div class="grid grid-cols-7 gap-y-0.5 my-1">
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">1</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">2</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">3</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10  bg-blue-500 text-white font-medium rounded-full">4</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">5</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">6</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">7</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">8</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">9</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">10</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">11</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">12</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">13</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">14</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">15</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">16</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">17</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">18</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">19</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">20</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">21</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">22</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">23</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">24</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">25</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">26</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">27</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">28</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">29</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">30</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">1</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">2</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">3</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">4</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">5</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">6</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">7</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">8</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">9</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">10</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">11</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">12</button>
                          </div>
                        </div>
                      </div>
                      <div class="flex items-center">
                        <div class="bg-blue-500 h-7 w-1 rounded-full hidden md:block bg-blue-500"></div>
                      </div>
                      <div class="w-full md:w-[297px] md:min-w-[297px]">
                        <div class="flex items-center space-x-1.5 border border-gray-300 dark:border-gray-700 rounded-md px-2 py-1.5">
                          <div class="flex-none">
                            <button type="button" class="dark:text-white/70 dark:hover:bg-white/10 dark:focus:bg-white/10 transition-all duration-300 hover:bg-gray-100 rounded-full p-[0.45rem] focus:ring-1 focus:ring-blue-500/50 focus:bg-blue-100/50">
                              <svg class="h-5 w-5"
                                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5"></path>
                              </svg>
                            </button>
                          </div>
                          <div class="flex flex-1 items-center space-x-1.5">
                            <div class="w-1/2">
                              <button type="button" class="w-full tracking-wide dark:text-white/70 dark:hover:bg-white/10 dark:focus:bg-white/10 transition-all duration-300 px-3 py-[0.55rem] uppercase hover:bg-gray-100 rounded-md focus:ring-1 focus:ring-blue-500/50 focus:bg-blue-100/50">Jul</button>
                            </div>
                            <div class="w-1/2">
                              <button type="button" class="w-full tracking-wide dark:text-white/70 dark:hover:bg-white/10 dark:focus:bg-white/10 transition-all duration-300 px-3 py-[0.55rem] uppercase hover:bg-gray-100 rounded-md focus:ring-1 focus:ring-blue-500/50 focus:bg-blue-100/50">2025</button>
                            </div>
                          </div>
                          <div class="flex-none">
                            <button type="button" class="dark:text-white/70 dark:hover:bg-white/10 dark:focus:bg-white/10 transition-all duration-300 hover:bg-gray-100 rounded-full p-[0.45rem] focus:ring-1 focus:ring-blue-500/50 focus:bg-blue-100/50">
                              <svg class="h-5 w-5"
                                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5"></path>
                              </svg>
                            </button>
                          </div>
                        </div>
                        <div class="px-0.5 sm:px-2 mt-0.5 min-h-[285px]">
                          <div class="grid grid-cols-7 border-b border-gray-300 dark:border-gray-700 py-2">
                            <div class="tracking-wide text-gray-500 text-center">Sun</div>
                            <div class="tracking-wide text-gray-500 text-center">Mon</div>
                            <div class="tracking-wide text-gray-500 text-center">Tue</div>
                            <div class="tracking-wide text-gray-500 text-center">Wed</div>
                            <div class="tracking-wide text-gray-500 text-center">Thu</div>
                            <div class="tracking-wide text-gray-500 text-center">Fri</div>
                            <div class="tracking-wide text-gray-500 text-center">Sat</div>
                          </div>
                          <div class="grid grid-cols-7 gap-y-0.5 my-1">
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">29</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">30</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">1</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">2</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">3</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">4</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">5</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">6</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">7</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">8</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">9</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">10</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">11</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">12</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">13</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">14</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">15</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">16</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">17</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">18</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">19</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">20</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">21</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">22</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">23</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">24</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">25</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">26</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">27</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">28</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">29</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">30</button>
                            <button type="button" class="flex items-center justify-center w-12 h-12 lg:w-10 lg:h-10">31</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">1</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">2</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">3</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">4</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">5</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">6</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">7</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">8</button>
                            <button type="button" class="flex items-center justify-center text-gray-400 h-12 w-12 lg:w-10 lg:h-10">9</button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="text-right ">
            <button class="btn btn-ghost btn-sm normal-case">
              <svg
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-4 mr-2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"></path>
              </svg>Refresh Data
            </button>
            <button class="btn btn-ghost btn-sm normal-case  ml-2">
              <svg
                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-4 mr-2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M7.217 10.907a2.25 2.25 0 100 2.186m0-2.186c.18.324.283.696.283 1.093s-.103.77-.283 1.093m0-2.186l9.566-5.314m-9.566 7.5l9.566 5.314m0 0a2.25 2.25 0 103.935 2.186 2.25 2.25 0 00-3.935-2.186zm0-12.814a2.25 2.25 0 103.933-2.185 2.25 2.25 0 00-3.933 2.185z"></path>
              </svg>Share
            </button>
            <div class="dropdown dropdown-bottom dropdown-end  ml-2">
              <label tabindex="0" class="btn btn-ghost btn-sm normal-case btn-square ">
                <svg
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-5">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 6.75a.75.75 0 110-1.5.75.75 0 010 1.5zM12 12.75a.75.75 0 110-1.5.75.75 0 010 1.5zM12 18.75a.75.75 0 110-1.5.75.75 0 010 1.5z"></path>
                </svg>
              </label>
              <ul tabindex="0" class="dropdown-content menu menu-compact  p-2 shadow bg-base-100 rounded-box w-52">
                <li>
                  <a>
                    <svg
                      xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-4">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75"></path>
                    </svg>Email Digests
                  </a>
                </li>
                <li>
                  <a>
                    <svg
                      xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-4">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3"></path>
                    </svg>Download
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="grid lg:grid-cols-4 mt-2 md:grid-cols-2 grid-cols-1 gap-6">
          <div class="stats shadow">
            <div class="stat">
              <div class="stat-figure dark:text-slate-300 text-primary">
                <svg
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-8 h-8">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 003.741-.479 3 3 0 00-4.682-2.72m.94 3.198l.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0112 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 016 18.719m12 0a5.971 5.971 0 00-.941-3.197m0 0A5.995 5.995 0 0012 12.75a5.995 5.995 0 00-5.058 2.772m0 0a3 3 0 00-4.681 2.72 8.986 8.986 0 003.74.477m.94-3.197a5.971 5.971 0 00-.94 3.197M15 6.75a3 3 0 11-6 0 3 3 0 016 0zm6 3a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0zm-13.5 0a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z"></path>
                </svg>
              </div>
              <div class="stat-title dark:text-slate-300">New Users</div>
              <div class="stat-value dark:text-slate-300 text-primary">34.7k</div>
              <div class="stat-desc  font-bold text-green-700 dark:text-green-300">↗︎ 2300 (22%)</div>
            </div>
          </div>
          <div class="stats shadow">
            <div class="stat">
              <div class="stat-figure dark:text-slate-300 text-primary">
                <svg
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-8 h-8">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 8.25h19.5M2.25 9h19.5m-16.5 5.25h6m-6 2.25h3m-3.75 3h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5z"></path>
                </svg>
              </div>
              <div class="stat-title dark:text-slate-300">Total Sales</div>
              <div class="stat-value dark:text-slate-300 text-primary">$34,545</div>
              <div class="stat-desc  ">Current month</div>
            </div>
          </div>
          <div class="stats shadow">
            <div class="stat">
              <div class="stat-figure dark:text-slate-300 text-primary">
                <svg
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-8 h-8">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M20.25 6.375c0 2.278-3.694 4.125-8.25 4.125S3.75 8.653 3.75 6.375m16.5 0c0-2.278-3.694-4.125-8.25-4.125S3.75 4.097 3.75 6.375m16.5 0v11.25c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125V6.375m16.5 0v3.75m-16.5-3.75v3.75m16.5 0v3.75C20.25 16.153 16.556 18 12 18s-8.25-1.847-8.25-4.125v-3.75m16.5 0c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125"></path>
                </svg>
              </div>
              <div class="stat-title dark:text-slate-300">Pending Leads</div>
              <div class="stat-value dark:text-slate-300 text-primary">450</div>
              <div class="stat-desc  ">50 in hot leads</div>
            </div>
          </div>
          <div class="stats shadow">
            <div class="stat">
              <div class="stat-figure dark:text-slate-300 text-primary">
                <svg
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-8 h-8">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"></path>
                </svg>
              </div>
              <div class="stat-title dark:text-slate-300">Active Users</div>
              <div class="stat-value dark:text-slate-300 text-primary">5.6k</div>
              <div class="stat-desc  font-bold text-rose-500 dark:text-red-400">↙ 300 (18%)</div>
            </div>
          </div>
        </div>
        <div class="grid lg:grid-cols-2 mt-4 grid-cols-1 gap-6">
          <div class="card w-full p-6 bg-base-100 shadow-xl mt-6">
            <div class="text-xl font-semibold ">Montly Active Users (in K)</div>
            <div class="divider mt-2"></div>
            <div class="h-full w-full pb-6 bg-base-100">
              <canvas role="img" height="354" width="708" style="display: block; box-sizing: border-box; height: 354px; width: 708px;"></canvas>
            </div>
          </div>
          <div class="card w-full p-6 bg-base-100 shadow-xl mt-6">
            <div class="text-xl font-semibold ">Revenue</div>
            <div class="divider mt-2"></div>
            <div class="h-full w-full pb-6 bg-base-100">
              <canvas role="img" height="354" width="708" style="display: block; box-sizing: border-box; height: 354px; width: 708px;"></canvas>
            </div>
          </div>
        </div>
        <div class="grid lg:grid-cols-2 mt-10 grid-cols-1 gap-6">
          <div class="stats bg-base-100 shadow">
            <div class="stat">
              <div class="stat-title">Amount to be Collected</div>
              <div class="stat-value">$25,600</div>
              <div class="stat-actions">
                <button class="btn btn-xs">View Users</button>
              </div>
            </div>
            <div class="stat">
              <div class="stat-title">Cash in hand</div>
              <div class="stat-value">$5,600</div>
              <div class="stat-actions">
                <button class="btn btn-xs">View Members</button>
              </div>
            </div>
          </div>
          <div class="stats bg-base-100 shadow">
            <div class="stat">
              <div class="stat-figure invisible md:visible">
                <svg
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-8 h-8">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"></path>
                </svg>
              </div>
              <div class="stat-title">Total Likes</div>
              <div class="stat-value">25.6K</div>
              <div class="stat-desc">21% more than last month</div>
            </div>
            <div class="stat">
              <div class="stat-figure invisible md:visible">
                <svg
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true" class="w-8 h-8">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 13.5l10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75z"></path>
                </svg>
              </div>
              <div class="stat-title">Page Views</div>
              <div class="stat-value">2.6M</div>
              <div class="stat-desc">14% more than last month</div>
            </div>
          </div>
        </div>
        <div class="grid lg:grid-cols-2 mt-4 grid-cols-1 gap-6">
          <div class="card w-full p-6 bg-base-100 shadow-xl mt-6">
            <div class="text-xl font-semibold ">User Signup Source</div>
            <div class="divider mt-2"></div>
            <div class="h-full w-full pb-6 bg-base-100">
              <div class="overflow-x-auto">
                <table class="table w-full">
                  <thead>
                    <tr>
                      <th></th>
                      <th class="normal-case">Source</th>
                      <th class="normal-case">No of Users</th>
                      <th class="normal-case">Conversion</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <th>1</th>
                      <td>Facebook Ads</td>
                      <td>26,345</td>
                      <td>10.2%</td>
                    </tr>
                    <tr>
                      <th>2</th>
                      <td>Google Ads</td>
                      <td>21,341</td>
                      <td>11.7%</td>
                    </tr>
                    <tr>
                      <th>3</th>
                      <td>Instagram Ads</td>
                      <td>34,379</td>
                      <td>12.4%</td>
                    </tr>
                    <tr>
                      <th>4</th>
                      <td>Affiliates</td>
                      <td>12,359</td>
                      <td>20.9%</td>
                    </tr>
                    <tr>
                      <th>5</th>
                      <td>Organic</td>
                      <td>10,345</td>
                      <td>10.3%</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="card w-full p-6 bg-base-100 shadow-xl mt-6">
            <div class="text-xl font-semibold ">Orders by Category</div>
            <div class="divider mt-2"></div>
            <div class="h-full w-full pb-6 bg-base-100">
              <canvas role="img" height="708" width="708" style="display: block; box-sizing: border-box; height: 708px; width: 708px;"></canvas>
            </div>
          </div>
        </div>
        <div class="h-16"></div>
      </main>
    </div>
    """
  end
end
